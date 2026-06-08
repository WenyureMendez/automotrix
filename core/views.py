from django.shortcuts import render, get_object_or_404, redirect
from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test
from django.utils import timezone
from django.db.models import Sum, Count, Q
from django.http import JsonResponse
from .models import (Customers, Vehicles, Mechanics, Services, Spareparts,
                     Appointments, Insurances, Workorders, Workorderservices,
                     Workorderspareparts, Invoices, Payments)
import re
from datetime import date
from decimal import Decimal

def validar_cliente(post):
    errores = []
    if not re.match(r'^[A-Za-záéíóúÁÉÍÓÚñÑ\s]+$', post.get('first_name', '')):
        errores.append('El nombre solo puede contener letras.')
    if not re.match(r'^[A-Za-záéíóúÁÉÍÓÚñÑ\s]+$', post.get('last_name', '')):
        errores.append('El apellido solo puede contener letras.')
    if not re.match(r'^\d{10}$', post.get('phone', '')):
        errores.append('El teléfono debe tener exactamente 10 dígitos.')
    return errores

def is_admin(user):
    return user.is_superuser or user.groups.filter(name='Administrador').exists()

def is_recepcionista(user):
    return user.is_superuser or user.groups.filter(name__in=['Administrador', 'Recepcionista']).exists()

def is_mecanico(user):
    return user.is_superuser or user.groups.filter(name__in=['Administrador', 'Mecánico']).exists()

def is_recepcionista_o_mecanico(user):
    return user.is_superuser or user.groups.filter(
        name__in=['Administrador', 'Recepcionista', 'Mecánico']
    ).exists()

def asignar_mecanico():
    return Mechanics.objects.annotate(
        citas_activas=Count(
            'appointments',
            filter=Q(appointments__status__in=['Pendiente', 'En proceso'])
        )
    ).order_by('citas_activas').first()

# ─── DASHBOARD ───────────────────────────────────────────────
@login_required(login_url='/login/')
def dashboard(request):
    user = request.user
    context = {
        'total_customers': Customers.objects.count(),
        'total_vehicles': Vehicles.objects.count(),
        'total_mechanics': Mechanics.objects.count(),
        'total_appointments': Appointments.objects.count(),
        'total_invoices': Invoices.objects.count(),
        'total_revenue': Invoices.objects.aggregate(Sum('total'))['total__sum'] or 0,
        'total_workorders': Workorders.objects.count(),
        'total_services': Services.objects.count(),
        'total_spareparts': Spareparts.objects.count(),
        'is_admin': is_admin(user),
        'is_recepcionista': is_recepcionista(user),
        'is_mecanico': is_mecanico(user),
    }
    return render(request, 'core/dashboard.html', context)

# ─── CLIENTES ────────────────────────────────────────────────
@user_passes_test(is_recepcionista_o_mecanico, login_url='/login/')
def customers_list(request):
    return render(request, 'core/customers.html', {'customers': Customers.objects.all().order_by('-id')})

@user_passes_test(is_recepcionista, login_url='/login/')
def customer_create(request):
    if request.method == 'POST':
        errores = validar_cliente(request.POST)
        if errores:
            for error in errores:
                messages.error(request, error)
            return render(request, 'core/customer_form.html', {
                'action': 'Crear',
                'services': Services.objects.all().order_by('name'),
            })
        try:
            customer = Customers.objects.create(
                first_name=request.POST["first_name"],
                last_name=request.POST["last_name"],
                cedula=request.POST.get("cedula", "") or None,
                phone=request.POST["phone"],
                email=request.POST["email"],
            )
        except Exception:
            messages.error(request, "Ya existe un cliente registrado con esa cédula.")
            return render(request, "core/customer_form.html", {
                "action": "Crear",
                "services": Services.objects.all().order_by("name"),
            })
        if request.POST.get('brand') and request.POST.get('plate'):
            if Vehicles.objects.filter(plate=request.POST['plate'].upper()).exists():
                messages.error(request, f"La placa {request.POST['plate'].upper()} ya está registrada en otro vehículo.")
                return render(request, 'core/customer_form.html', {
                    'action': 'Crear',
                    'services': Services.objects.all().order_by('name'),
                })
            vehicle = Vehicles.objects.create(
                customer=customer,
                brand=request.POST['brand'],
                model=request.POST.get('model', ''),
                plate=request.POST['plate'].upper(),
            )
            mecanico = asignar_mecanico()
            payment_method = request.POST.get('payment_method', 'Efectivo')
            Appointments.objects.create(
                customer=customer,
                vehicle=vehicle,
                mechanic=mecanico,
                appointment_date=timezone.now(),
                reason=request.POST.get('problem', 'Sin descripción'),
                status='Pendiente',
                tipo='Llegada directa',
            )
            workorder = Workorders.objects.create(
                vehicle=vehicle,
                mechanic=mecanico,
                status='Diagnóstico',
                start_date=date.today(),
                end_date=None,
            )
            services_ids = request.POST.get('services', '')
            total = Decimal('0.00')
            if services_ids:
                for sid in services_ids.split(','):
                    sid = sid.strip()
                    if sid:
                        try:
                            servicio = Services.objects.get(id=int(sid))
                            Workorderservices.objects.create(workorder=workorder, service=servicio)
                            total += servicio.price
                        except Services.DoesNotExist:
                            pass
            invoice = Invoices.objects.create(
                date=date.today(),
                total=total,
                workorder=workorder,
                status='Pendiente',
                payment_method=payment_method,
            )
            Payments.objects.create(
                amount=total,
                payment_date=date.today(),
                method=payment_method,
                invoice=invoice,
                status='Pendiente',
            )
        messages.success(request, 'Cliente registrado correctamente.')
        return redirect('customers_list')
    return render(request, 'core/customer_form.html', {
        'action': 'Crear',
        'services': Services.objects.all().order_by('name'),
    })

@user_passes_test(is_recepcionista, login_url='/login/')
def customer_edit(request, pk):
    obj = get_object_or_404(Customers, pk=pk)
    if request.method == 'POST':
        obj.first_name = request.POST['first_name']
        obj.last_name = request.POST['last_name']
        obj.cedula = request.POST.get('cedula', '') or None
        obj.phone = request.POST['phone']
        obj.email = request.POST['email']
        obj.save()
        messages.success(request, 'Cliente actualizado correctamente.')
        return redirect('customers_list')
    return render(request, 'core/customer_form.html', {'action': 'Editar', 'obj': obj})

@user_passes_test(is_admin, login_url='/login/')
def customer_delete(request, pk):
    obj = get_object_or_404(Customers, pk=pk)
    if request.method == 'POST':
        # Eliminar dependencias antes de eliminar el cliente
        vehiculos = Vehicles.objects.filter(customer=obj)
        for v in vehiculos:
            workorders = Workorders.objects.filter(vehicle=v)
            for w in workorders:
                Workorderservices.objects.filter(workorder=w).delete()
                Workorderspareparts.objects.filter(workorder=w).delete()
                invoices = Invoices.objects.filter(workorder=w)
                for i in invoices:
                    Payments.objects.filter(invoice=i).delete()
                invoices.delete()
            workorders.delete()
            Appointments.objects.filter(vehicle=v).delete()
        vehiculos.delete()
        obj.delete()
        messages.success(request, 'Cliente eliminado correctamente.')
        return redirect('customers_list')
    return render(request, 'core/confirm_delete.html', {'obj': obj, 'nombre': f'{obj.first_name} {obj.last_name}', 'back': 'customers_list'})

# ─── VEHÍCULOS ───────────────────────────────────────────────
@user_passes_test(is_recepcionista_o_mecanico, login_url='/login/')
def vehicles_list(request):
    return render(request, 'core/vehicles.html', {'vehicles': Vehicles.objects.select_related('customer').all().order_by('-id')})

@user_passes_test(is_recepcionista, login_url='/login/')
def vehicle_create(request):
    if request.method == 'POST':
        placa = request.POST['plate'].upper()
        if Vehicles.objects.filter(plate=placa).exists():
            messages.error(request, f'La placa {placa} ya está registrada en otro vehículo.')
            return render(request, 'core/vehicle_form.html', {'action': 'Crear', 'customers': Customers.objects.all().order_by('-id')})
        Vehicles.objects.create(
            customer=get_object_or_404(Customers, pk=request.POST['customer']),
            brand=request.POST['brand'],
            model=request.POST['model'],
            plate=placa,
        )
        messages.success(request, 'Vehículo creado correctamente.')
        return redirect('vehicles_list')
    return render(request, 'core/vehicle_form.html', {'action': 'Crear', 'customers': Customers.objects.all().order_by('-id')})

@user_passes_test(is_recepcionista, login_url='/login/')
def vehicle_edit(request, pk):
    obj = get_object_or_404(Vehicles, pk=pk)
    if request.method == 'POST':
        obj.customer = get_object_or_404(Customers, pk=request.POST['customer'])
        obj.brand = request.POST['brand']
        obj.model = request.POST['model']
        obj.plate = request.POST['plate']
        obj.save()
        messages.success(request, 'Vehículo actualizado correctamente.')
        return redirect('vehicles_list')
    return render(request, 'core/vehicle_form.html', {'action': 'Editar', 'obj': obj, 'customers': Customers.objects.all().order_by('-id')})

@user_passes_test(is_admin, login_url='/login/')
def vehicle_delete(request, pk):
    obj = get_object_or_404(Vehicles, pk=pk)
    if request.method == 'POST':
        obj.delete()
        messages.success(request, 'Vehículo eliminado correctamente.')
        return redirect('vehicles_list')
    return render(request, 'core/confirm_delete.html', {'obj': obj, 'nombre': f'{obj.brand} {obj.plate}', 'back': 'vehicles_list'})

# ─── MECÁNICOS ───────────────────────────────────────────────
@user_passes_test(is_admin, login_url='/login/')
def mechanics_list(request):
    mechanics = Mechanics.objects.annotate(
        total_ordenes=Count('workorders', distinct=True),
        total_ganado=Sum('workorders__invoices__total'),
    ).order_by('-total_ganado')
    return render(request, 'core/mechanics.html', {'mechanics': mechanics})

@user_passes_test(is_admin, login_url='/login/')
def mechanic_create(request):
    if Mechanics.objects.count() >= 150:
        messages.error(request, 'No se pueden registrar más de 150 mecánicos.')
        return redirect('mechanics_list')
    if request.method == 'POST':
        Mechanics.objects.create(
            first_name=request.POST['first_name'],
            last_name=request.POST['last_name'],
            specialty=request.POST['specialty'],
        )
        messages.success(request, 'Mecánico creado correctamente.')
        return redirect('mechanics_list')
    return render(request, 'core/mechanic_form.html', {'action': 'Crear'})

@user_passes_test(is_admin, login_url='/login/')
def mechanic_edit(request, pk):
    obj = get_object_or_404(Mechanics, pk=pk)
    if request.method == 'POST':
        obj.first_name = request.POST['first_name']
        obj.last_name = request.POST['last_name']
        obj.cedula = request.POST.get('cedula', '') or None
        obj.specialty = request.POST['specialty']
        obj.save()
        messages.success(request, 'Mecánico actualizado correctamente.')
        return redirect('mechanics_list')
    return render(request, 'core/mechanic_form.html', {'action': 'Editar', 'obj': obj})

@user_passes_test(is_admin, login_url='/login/')
def mechanic_delete(request, pk):
    obj = get_object_or_404(Mechanics, pk=pk)
    if request.method == 'POST':
        obj.delete()
        messages.success(request, 'Mecánico eliminado correctamente.')
        return redirect('mechanics_list')
    return render(request, 'core/confirm_delete.html', {'obj': obj, 'nombre': f'{obj.first_name} {obj.last_name}', 'back': 'mechanics_list'})

# ─── SERVICIOS ───────────────────────────────────────────────
@user_passes_test(is_recepcionista_o_mecanico, login_url='/login/')
def services_list(request):
    return render(request, 'core/services.html', {'services': Services.objects.all().order_by('-id')})

@user_passes_test(is_admin, login_url='/login/')
def service_create(request):
    if request.method == 'POST':
        Services.objects.create(name=request.POST['name'], price=request.POST['price'].replace('.', '').replace(',', '.'))
        messages.success(request, 'Servicio creado correctamente.')
        return redirect('services_list')
    return render(request, 'core/service_form.html', {'action': 'Crear'})

@user_passes_test(is_admin, login_url='/login/')
def service_edit(request, pk):
    obj = get_object_or_404(Services, pk=pk)
    if request.method == 'POST':
        obj.name = request.POST['name']
        obj.price = request.POST['price'].replace('.', '').replace(',', '.')
        obj.save()
        messages.success(request, 'Servicio actualizado correctamente.')
        return redirect('services_list')
    return render(request, 'core/service_form.html', {'action': 'Editar', 'obj': obj})

@user_passes_test(is_admin, login_url='/login/')
def service_delete(request, pk):
    obj = get_object_or_404(Services, pk=pk)
    if request.method == 'POST':
        obj.delete()
        messages.success(request, 'Servicio eliminado correctamente.')
        return redirect('services_list')
    return render(request, 'core/confirm_delete.html', {'obj': obj, 'nombre': obj.name, 'back': 'services_list'})

# ─── REPUESTOS ───────────────────────────────────────────────
@user_passes_test(is_recepcionista_o_mecanico, login_url='/login/')
def spareparts_list(request):
    return render(request, 'core/spareparts.html', {'spareparts': Spareparts.objects.all().order_by('-id')})

@user_passes_test(is_admin, login_url='/login/')
def sparepart_create(request):
    if request.method == 'POST':
        Spareparts.objects.create(name=request.POST['name'], price=request.POST['price'].replace('.', '').replace(',', '.'), stock=request.POST['stock'])
        messages.success(request, 'Repuesto creado correctamente.')
        return redirect('spareparts_list')
    return render(request, 'core/sparepart_form.html', {'action': 'Crear'})

@user_passes_test(is_admin, login_url='/login/')
def sparepart_edit(request, pk):
    obj = get_object_or_404(Spareparts, pk=pk)
    if request.method == 'POST':
        obj.name = request.POST['name']
        obj.price = request.POST['price'].replace('.', '').replace(',', '.')
        obj.stock = request.POST['stock']
        obj.save()
        messages.success(request, 'Repuesto actualizado correctamente.')
        return redirect('spareparts_list')
    return render(request, 'core/sparepart_form.html', {'action': 'Editar', 'obj': obj})

@user_passes_test(is_admin, login_url='/login/')
def sparepart_delete(request, pk):
    obj = get_object_or_404(Spareparts, pk=pk)
    if request.method == 'POST':
        obj.delete()
        messages.success(request, 'Repuesto eliminado correctamente.')
        return redirect('spareparts_list')
    return render(request, 'core/confirm_delete.html', {'obj': obj, 'nombre': obj.name, 'back': 'spareparts_list'})

# ─── CITAS ───────────────────────────────────────────────────
@user_passes_test(is_recepcionista_o_mecanico, login_url='/login/')
def appointments_list(request):
    return render(request, 'core/appointments.html', {'appointments': Appointments.objects.select_related('customer', 'vehicle', 'mechanic').all().order_by('-id')})

@user_passes_test(is_recepcionista, login_url='/login/')
def appointment_create(request):
    if request.method == 'POST':
        email = request.POST['email']
        cedula = request.POST.get('cedula', '') or None
        placa = request.POST['plate'].upper()

        # Buscar cliente existente por cédula, email o placa
        customer = None
        if cedula:
            customer = Customers.objects.filter(cedula=cedula).first()
        if not customer:
            customer = Customers.objects.filter(email=email).first()
        if not customer:
            # Buscar por placa del vehículo
            vehiculo_existente = Vehicles.objects.filter(plate=placa).first()
            if vehiculo_existente:
                customer = vehiculo_existente.customer

        if customer:
            # Actualizar datos del cliente existente
            customer.first_name = request.POST['first_name']
            customer.last_name = request.POST['last_name']
            customer.phone = request.POST['phone']
            customer.email = email
            if cedula:
                customer.cedula = cedula
            customer.save()
        else:
            # Crear nuevo cliente
            customer = Customers.objects.create(
                first_name=request.POST['first_name'],
                last_name=request.POST['last_name'],
                cedula=cedula,
                phone=request.POST['phone'],
                email=email,
            )

        # Reutilizar vehículo existente o crear nuevo
        vehicle, _ = Vehicles.objects.get_or_create(
            plate=placa,
            defaults={
                'customer': customer,
                'brand': request.POST['brand'],
                'model': request.POST['model'],
            }
        )
        mecanico = asignar_mecanico()
        tipo = request.POST.get('tipo', 'Cita previa')
        payment_method = request.POST.get('payment_method', 'Efectivo')
        appointment = Appointments.objects.create(
            customer=customer,
            vehicle=vehicle,
            mechanic=mecanico,
            appointment_date=request.POST['appointment_date'],
            reason=request.POST.get('reason', 'Sin descripción'),
            status='Pendiente',
            tipo=tipo,
        )
        workorder = Workorders.objects.create(
            vehicle=vehicle,
            mechanic=mecanico,
            status='Diagnóstico',
            start_date=date.today(),
            end_date=None,
        )
        appointment.workorder = workorder
        appointment.save()
        services_ids = request.POST.get('services', '')
        total = Decimal('0.00')
        if services_ids:
            for sid in services_ids.split(','):
                sid = sid.strip()
                if sid:
                    try:
                        servicio = Services.objects.get(id=int(sid))
                        Workorderservices.objects.create(workorder=workorder, service=servicio)
                        total += servicio.price
                    except Services.DoesNotExist:
                        pass
        if tipo == 'Llegada directa':
            invoice = Invoices.objects.create(
                date=date.today(),
                total=total,
                workorder=workorder,
                status='Pendiente',
                payment_method=payment_method,
            )
            Payments.objects.create(
                amount=total,
                payment_date=date.today(),
                method=payment_method,
                invoice=invoice,
                status='Pendiente',
            )
        messages.success(request, f'Cita y orden de trabajo creadas. Asignadas a {mecanico.first_name} {mecanico.last_name}.')
        return redirect('appointments_list')
    return render(request, 'core/appointment_form.html', {
        'action': 'Crear',
        'services': Services.objects.all().order_by('name'),
    })

@user_passes_test(is_recepcionista, login_url='/login/')
def appointment_edit(request, pk):
    obj = get_object_or_404(Appointments, pk=pk)
    if request.method == 'POST':
        obj.customer = get_object_or_404(Customers, pk=request.POST['customer'])
        obj.vehicle = get_object_or_404(Vehicles, pk=request.POST['vehicle'])
        obj.appointment_date = request.POST['appointment_date']
        obj.reason = request.POST['reason']
        obj.status = request.POST.get('status', obj.status)
        obj.tipo = request.POST.get('tipo', obj.tipo)
        obj.save()
        messages.success(request, 'Cita actualizada correctamente.')
        return redirect('appointments_list')
    return render(request, 'core/appointment_form.html', {
        'action': 'Editar', 'obj': obj,
        'customers': Customers.objects.all().order_by('-id'),
        'vehicles': Vehicles.objects.all().order_by('-id'),
        'mechanics': Mechanics.objects.all(),
        'services': Services.objects.all().order_by('name'),
    })

@user_passes_test(is_admin, login_url='/login/')
def appointment_delete(request, pk):
    obj = get_object_or_404(Appointments, pk=pk)
    if request.method == 'POST':
        obj.delete()
        messages.success(request, 'Cita eliminada correctamente.')
        return redirect('appointments_list')
    return render(request, 'core/confirm_delete.html', {'obj': obj, 'nombre': obj.reason, 'back': 'appointments_list'})

# ─── SEGUROS ─────────────────────────────────────────────────
@user_passes_test(is_admin, login_url='/login/')
def insurances_list(request):
    return render(request, 'core/insurances.html', {'insurances': Insurances.objects.select_related('vehicle').all().order_by('-id'), 'today': date.today()})

@user_passes_test(is_admin, login_url='/login/')
def insurance_create(request):
    if request.method == 'POST':
        vehicle = get_object_or_404(Vehicles, pk=request.POST['vehicle'])
        if Insurances.objects.filter(vehicle=vehicle).exists():
            messages.error(request, f'El vehículo {vehicle.plate} ya tiene un seguro registrado.')
            return render(request, 'core/insurance_form.html', {
                'action': 'Crear',
                'vehicles': Vehicles.objects.all()
            })
        Insurances.objects.create(
            company_name=request.POST['company_name'],
            policy_number=request.POST['policy_number'],
            start_date=request.POST['start_date'],
            end_date=request.POST['end_date'],
            vehicle=vehicle,
        )
        messages.success(request, 'Seguro creado correctamente.')
        return redirect('insurances_list')
    vehiculos_sin_seguro = Vehicles.objects.filter(insurances__isnull=True)
    return render(request, 'core/insurance_form.html', {'action': 'Crear', 'vehicles': vehiculos_sin_seguro})

@user_passes_test(is_admin, login_url='/login/')
def insurance_edit(request, pk):
    obj = get_object_or_404(Insurances, pk=pk)
    if request.method == 'POST':
        obj.company_name = request.POST['company_name']
        obj.policy_number = request.POST['policy_number']
        obj.start_date = request.POST['start_date']
        obj.end_date = request.POST['end_date']
        obj.vehicle = get_object_or_404(Vehicles, pk=request.POST['vehicle'])
        obj.save()
        messages.success(request, 'Seguro actualizado correctamente.')
        return redirect('insurances_list')
    return render(request, 'core/insurance_form.html', {'action': 'Editar', 'obj': obj, 'vehicles': Vehicles.objects.all()})

@user_passes_test(is_admin, login_url='/login/')
def insurance_delete(request, pk):
    obj = get_object_or_404(Insurances, pk=pk)
    if request.method == 'POST':
        obj.delete()
        messages.success(request, 'Seguro eliminado correctamente.')
        return redirect('insurances_list')
    return render(request, 'core/confirm_delete.html', {'obj': obj, 'nombre': obj.policy_number, 'back': 'insurances_list'})

# ─── ÓRDENES DE TRABAJO ──────────────────────────────────────
@user_passes_test(is_recepcionista_o_mecanico, login_url='/login/')
def workorders_list(request):
    status = request.GET.get('status')
    workorders = Workorders.objects.select_related('vehicle', 'mechanic').all().order_by('-id')
    if status:
        workorders = workorders.filter(status=status)
    return render(request, 'core/workorders.html', {'workorders': workorders})

@user_passes_test(is_mecanico, login_url='/login/')
def workorder_create(request):
    if request.method == 'POST':
        mecanico = asignar_mecanico()
        Workorders.objects.create(
            vehicle=get_object_or_404(Vehicles, pk=request.POST['vehicle']),
            mechanic=mecanico,
            status=request.POST['status'],
            start_date=request.POST['start_date'],
            end_date=request.POST.get('end_date') or None,
        )
        messages.success(request, f'Orden creada y asignada a {mecanico.first_name} {mecanico.last_name}.')
        return redirect('workorders_list')
    return render(request, 'core/workorder_form.html', {
        'action': 'Crear',
        'vehicles': Vehicles.objects.all().order_by('-id'),
        'mechanics': Mechanics.objects.all(),
    })

@user_passes_test(is_recepcionista_o_mecanico, login_url='/login/')
def workorder_edit(request, pk):
    obj = get_object_or_404(Workorders, pk=pk)
    if request.method == 'POST':
        obj.vehicle = get_object_or_404(Vehicles, pk=request.POST['vehicle'])
        obj.status = request.POST['status']
        obj.start_date = request.POST['start_date']
        obj.end_date = request.POST.get('end_date') or None
        obj.save()
        messages.success(request, 'Orden actualizada correctamente.')
        return redirect('workorders_list')
    return render(request, 'core/workorder_form.html', {
        'action': 'Editar', 'obj': obj,
        'vehicles': Vehicles.objects.all().order_by('-id'),
        'mechanics': Mechanics.objects.all(),
        'mechanics': Mechanics.objects.all(),
    })

@user_passes_test(is_recepcionista_o_mecanico, login_url='/login/')
def workorder_delete(request, pk):
    obj = get_object_or_404(Workorders, pk=pk)
    if request.method == 'POST':
        obj.delete()
        messages.success(request, 'Orden eliminada correctamente.')
        return redirect('workorders_list')
    return render(request, 'core/confirm_delete.html', {'obj': obj, 'nombre': f'Orden #{obj.id}', 'back': 'workorders_list'})

def workorder_status(request, pk):
    obj = get_object_or_404(Workorders, pk=pk)
    if request.method == 'POST':
        obj.status = request.POST['status']
        if obj.status == 'Finalizada' and not obj.end_date:
            obj.end_date = date.today()
            obj.save()
            if not Invoices.objects.filter(workorder=obj).exists():
                total = Workorderservices.objects.filter(workorder=obj).select_related('service').aggregate(
                    total=Sum('service__price')
                )['total'] or Decimal('0.00')
                Invoices.objects.create(
                    date=date.today(),
                    total=total,
                    workorder=obj,
                    status='Pendiente',
                    payment_method='Efectivo',
                )
                messages.success(request, f'Orden finalizada. Factura creada por ${total:,.0f}.')
            else:
                messages.success(request, f'Estado actualizado a {obj.status}.')
        else:
            obj.save()
            messages.success(request, f'Estado actualizado a {obj.status}.')
    return redirect('workorders_list')

# ─── SERVICIOS DE OT ─────────────────────────────────────────
@user_passes_test(is_admin, login_url='/login/')
def workorderservices_list(request):
    return render(request, 'core/workorderservices.html', {
        'items': Workorderservices.objects.select_related('workorder', 'service').all().order_by('-id')
    })

@user_passes_test(is_admin, login_url='/login/')
def workorderservice_create(request):
    if request.method == 'POST':
        Workorderservices.objects.create(
            workorder=get_object_or_404(Workorders, pk=request.POST['workorder']),
            service=get_object_or_404(Services, pk=request.POST['service']),
        )
        messages.success(request, 'Servicio agregado a la orden correctamente.')
        return redirect('workorderservices_list')
    return render(request, 'core/workorderservice_form.html', {
        'workorders': Workorders.objects.all(),
        'services': Services.objects.all(),
    })

@user_passes_test(is_admin, login_url='/login/')
def workorderservice_delete(request, pk):
    obj = get_object_or_404(Workorderservices, pk=pk)
    if request.method == 'POST':
        obj.delete()
        messages.success(request, 'Servicio eliminado de la orden.')
        return redirect('workorderservices_list')
    return render(request, 'core/confirm_delete.html', {'obj': obj, 'nombre': f'Servicio de Orden #{obj.workorder.id}', 'back': 'workorderservices_list'})

# ─── REPUESTOS DE OT ─────────────────────────────────────────
@user_passes_test(is_admin, login_url='/login/')
def workorderspareparts_list(request):
    return render(request, 'core/workorderspareparts.html', {
        'items': Workorderspareparts.objects.select_related('workorder', 'sparepart').all().order_by('-id')
    })

@user_passes_test(is_admin, login_url='/login/')
def workordersparepart_create(request):
    if request.method == 'POST':
        Workorderspareparts.objects.create(
            workorder=get_object_or_404(Workorders, pk=request.POST['workorder']),
            sparepart=get_object_or_404(Spareparts, pk=request.POST['sparepart']),
            quantity=request.POST['quantity'],
        )
        messages.success(request, 'Repuesto asignado correctamente.')
        return redirect('workorderspareparts_list')
    return render(request, 'core/workordersparepart_form.html', {
        'workorders': Workorders.objects.all(),
        'spareparts': Spareparts.objects.all(),
    })

@user_passes_test(is_admin, login_url='/login/')
def workordersparepart_delete(request, pk):
    obj = get_object_or_404(Workorderspareparts, pk=pk)
    if request.method == 'POST':
        obj.delete()
        messages.success(request, 'Repuesto eliminado de la orden.')
        return redirect('workorderspareparts_list')
    return render(request, 'core/confirm_delete.html', {'obj': obj, 'nombre': f'Repuesto de Orden #{obj.workorder.id}', 'back': 'workorderspareparts_list'})

# ─── FACTURAS ────────────────────────────────────────────────
@user_passes_test(is_recepcionista, login_url='/login/')
def invoices_list(request):
    return render(request, 'core/invoices.html', {'invoices': Invoices.objects.select_related('workorder').all().order_by('-id')})

@user_passes_test(is_admin, login_url='/login/')
def invoice_create(request):
    if request.method == 'POST':
        Invoices.objects.create(
            date=request.POST['date'],
            total=request.POST['total'],
            workorder=get_object_or_404(Workorders, pk=request.POST['workorder']),
            status='Pendiente',
        )
        messages.success(request, 'Factura creada correctamente.')
        return redirect('invoices_list')
    return render(request, 'core/invoice_form.html', {'action': 'Crear', 'workorders': Workorders.objects.all()})

@user_passes_test(is_admin, login_url='/login/')
def invoice_edit(request, pk):
    obj = get_object_or_404(Invoices, pk=pk)
    if request.method == 'POST':
        obj.date = request.POST['date']
        obj.total = request.POST['total']
        obj.workorder = get_object_or_404(Workorders, pk=request.POST['workorder'])
        obj.save()
        messages.success(request, 'Factura actualizada correctamente.')
        return redirect('invoices_list')
    return render(request, 'core/invoice_form.html', {'action': 'Editar', 'obj': obj, 'workorders': Workorders.objects.all()})

@user_passes_test(is_admin, login_url='/login/')
def invoice_delete(request, pk):
    obj = get_object_or_404(Invoices, pk=pk)
    if request.method == 'POST':
        obj.delete()
        messages.success(request, 'Factura eliminada correctamente.')
        return redirect('invoices_list')
    return render(request, 'core/confirm_delete.html', {'obj': obj, 'nombre': f'Factura #{obj.id}', 'back': 'invoices_list'})

# ─── BÚSQUEDA POR PLACA ──────────────────────────────────────

def api_orden_detalle(request, pk):
    w = get_object_or_404(Workorders, pk=pk)
    servicios = list(Workorderservices.objects.select_related('service').filter(workorder=w).values(
        'service__name', 'service__price'
    ))
    repuestos = list(Workorderspareparts.objects.select_related('sparepart').filter(workorder=w).values(
        'sparepart__name', 'sparepart__price', 'quantity'
    ))
    total = sum(s['service__price'] for s in servicios) + sum(r['sparepart__price'] * r['quantity'] for r in repuestos)
    return JsonResponse({
        'cliente': f"{w.vehicle.customer.first_name} {w.vehicle.customer.last_name}",
        'cedula': w.vehicle.customer.cedula or '',
        'telefono': w.vehicle.customer.phone,
        'email': w.vehicle.customer.email,
        'vehiculo': f"{w.vehicle.brand} {w.vehicle.model}",
        'placa': w.vehicle.plate,
        'mecanico': f"{w.mechanic.first_name} {w.mechanic.last_name}",
        'notas_mecanico': w.notas_mecanico or '',
        'servicios': servicios,
        'repuestos': repuestos,
        'total': float(total),
    })


@user_passes_test(is_recepcionista, login_url='/login/')
def invoice_detail(request, pk):
    invoice = get_object_or_404(Invoices, pk=pk)
    w = invoice.workorder
    servicios = Workorderservices.objects.select_related('service').filter(workorder=w)
    repuestos = Workorderspareparts.objects.select_related('sparepart').filter(workorder=w)
    return render(request, 'core/invoice_detail.html', {
        'invoice': invoice,
        'workorder': w,
        'servicios': servicios,
        'repuestos': repuestos,
    })

def buscar_por_placa(request):
    placa = request.GET.get('placa', '').strip().upper()
    if len(placa) < 2:
        return JsonResponse({'found': False, 'resultados': []})
    vehiculos = Vehicles.objects.select_related('customer').filter(plate__istartswith=placa)[:5]
    if not vehiculos.exists():
        return JsonResponse({'found': False, 'resultados': []})
    resultados = []
    for v in vehiculos:
        resultados.append({
            'first_name': v.customer.first_name,
            'last_name': v.customer.last_name,
            'phone': v.customer.phone,
            'email': v.customer.email,
            'brand': v.brand,
            'model': v.model,
            'plate': v.plate,
            'cedula': v.customer.cedula or '',
        })
    return JsonResponse({'found': True, 'resultados': resultados})

# ─── PAGOS ───────────────────────────────────────────────────
@user_passes_test(is_recepcionista, login_url='/login/')
def payments_list(request):
    return render(request, 'core/payments.html', {'payments': Payments.objects.select_related('invoice').all().order_by('-id')})

@user_passes_test(is_admin, login_url='/login/')
def payment_create(request):
    if request.method == 'POST':
        Payments.objects.create(
            amount=request.POST['amount'],
            payment_date=request.POST['payment_date'],
            method=request.POST['method'],
            invoice=get_object_or_404(Invoices, pk=request.POST['invoice']),
            status='Pendiente',
        )
        messages.success(request, 'Pago registrado correctamente.')
        return redirect('payments_list')
    return render(request, 'core/payment_form.html', {'action': 'Crear', 'invoices': Invoices.objects.all()})

@user_passes_test(is_admin, login_url='/login/')
def payment_edit(request, pk):
    obj = get_object_or_404(Payments, pk=pk)
    if request.method == 'POST':
        obj.amount = request.POST['amount']
        obj.payment_date = request.POST['payment_date']
        obj.method = request.POST['method']
        obj.invoice = get_object_or_404(Invoices, pk=request.POST['invoice'])
        obj.save()
        messages.success(request, 'Pago actualizado correctamente.')
        return redirect('payments_list')
    return render(request, 'core/payment_form.html', {'action': 'Editar', 'obj': obj, 'invoices': Invoices.objects.all()})

@user_passes_test(is_recepcionista, login_url='/login/')
def payment_delete(request, pk):
    obj = get_object_or_404(Payments, pk=pk)
    if request.method == 'POST':
        obj.delete()
        messages.success(request, 'Pago eliminado correctamente.')
        return redirect('payments_list')
    return render(request, 'core/confirm_delete.html', {'obj': obj, 'nombre': f'Pago #{obj.id}', 'back': 'payments_list'})

@user_passes_test(is_admin, login_url='/login/')
def payment_confirm(request, pk):
    pago = get_object_or_404(Payments, pk=pk)
    if request.method == 'POST':
        pago.status = 'Pagado'
        pago.save()
        factura = pago.invoice
        factura.status = 'Pagada'
        factura.save()
        workorder = factura.workorder
        appointment = Appointments.objects.filter(
            vehicle=workorder.vehicle,
            tipo='Llegada directa',
            status='Pendiente'
        ).first()
        if appointment:
            appointment.status = 'En proceso'
            appointment.save()
        total_actual = Workorderservices.objects.filter(
            workorder=workorder
        ).select_related('service').aggregate(
            total=Sum('service__price')
        )['total'] or Decimal('0.00')
        if total_actual > factura.total:
            excedente = total_actual - factura.total
            messages.warning(
                request,
                f'⚠️ El costo actual de la orden (${total_actual:,.0f}) supera el precio pactado '
                f'(${factura.total:,.0f}). El excedente de ${excedente:,.0f} '
                f'deberá pagarse al momento de entregar el vehículo.'
            )
        else:
            messages.success(
                request,
                f'Pago #{pago.id} confirmado. Factura #{factura.id} pagada. Cita pasó a "En proceso".'
            )
    return redirect('payments_list')
# ─── AGREGAR/QUITAR SERVICIOS Y REPUESTOS EN OT ──────────────
@user_passes_test(is_recepcionista_o_mecanico, login_url='/login/')
def workorder_add_service(request, pk):
    if request.method == 'POST':
        workorder = get_object_or_404(Workorders, pk=pk)
        service = get_object_or_404(Services, pk=request.POST['service'])
        Workorderservices.objects.create(workorder=workorder, service=service)
        messages.success(request, f'Servicio "{service.name}" agregado correctamente.')
    return redirect('workorder_edit', pk=pk)

@user_passes_test(is_recepcionista_o_mecanico, login_url='/login/')
def workorder_remove_service(request, pk):
    if request.method == 'POST':
        obj = get_object_or_404(Workorderservices, pk=pk)
        workorder_id = obj.workorder.id
        obj.delete()
        messages.success(request, 'Servicio eliminado de la orden.')
        return redirect('workorder_edit', pk=workorder_id)
    return redirect('workorders_list')

@user_passes_test(is_recepcionista_o_mecanico, login_url='/login/')
def workorder_add_sparepart(request, pk):
    if request.method == 'POST':
        workorder = get_object_or_404(Workorders, pk=pk)
        sparepart = get_object_or_404(Spareparts, pk=request.POST['sparepart'])
        quantity = int(request.POST.get('quantity', 1))
        Workorderspareparts.objects.create(workorder=workorder, sparepart=sparepart, quantity=quantity)
        messages.success(request, f'Repuesto "{sparepart.name}" agregado correctamente.')
    return redirect('workorder_edit', pk=pk)

@user_passes_test(is_recepcionista_o_mecanico, login_url='/login/')
def workorder_remove_sparepart(request, pk):
    if request.method == 'POST':
        obj = get_object_or_404(Workorderspareparts, pk=pk)
        workorder_id = obj.workorder.id
        obj.delete()
        messages.success(request, 'Repuesto eliminado de la orden.')
        return redirect('workorder_edit', pk=workorder_id)
    return redirect('workorders_list')

# ─── LOGIN CON RECAPTCHA ─────────────────────────────────────
import urllib.request
import urllib.parse
import json

def login_view(request):
    from django.contrib.auth.forms import AuthenticationForm
    from django.contrib.auth import authenticate, login
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        recaptcha_response = request.POST.get('g-recaptcha-response')

        # Verificar reCAPTCHA
        url = 'https://www.google.com/recaptcha/api/siteverify'
        values = {
            'secret': '6LcEug0tAAAAAA3KTFEtrSpH5Zawx20i1K3RMcz9',
            'response': recaptcha_response,
        }
        data = urllib.parse.urlencode(values).encode()
        req = urllib.request.Request(url, data=data)
        response = urllib.request.urlopen(req)
        result = json.loads(response.read().decode())

        if not result.get('success'):
            messages.error(request, 'Por favor completa el captcha.')
            return render(request, 'core/login.html', {'form': AuthenticationForm()})

        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('dashboard')
        else:
            messages.error(request, 'Usuario o contraseña incorrectos.')
            return render(request, 'core/login.html', {'form': AuthenticationForm()})

    return render(request, 'core/login.html', {'form': AuthenticationForm()})

# ─── CANCELAR CITA ───────────────────────────────────────────
@user_passes_test(is_recepcionista, login_url='/login/')
def appointment_cancel(request, pk):
    if request.method == 'POST':
        obj = get_object_or_404(Appointments, pk=pk)
        obj.status = 'Cancelada'
        obj.save()
        messages.success(request, f'Cita #{pk} cancelada.')
    return redirect('appointments_list')

# ─── PDF FACTURA ─────────────────────────────────────────────
from reportlab.lib.pagesizes import A4
from reportlab.lib import colors
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib.units import cm
from django.http import HttpResponse
import urllib.parse
from datetime import datetime

@user_passes_test(is_recepcionista, login_url='/login/')
def invoice_pdf(request, pk):
    invoice = get_object_or_404(Invoices, pk=pk)
    workorder = invoice.workorder
    vehicle = workorder.vehicle
    customer = vehicle.customer
    mechanic = workorder.mechanic
    servicios = Workorderservices.objects.select_related('service').filter(workorder=workorder)
    repuestos = Workorderspareparts.objects.select_related('sparepart').filter(workorder=workorder)
    generado_por = request.user.get_full_name() or request.user.username

    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = f'attachment; filename="factura_{pk}.pdf"'

    doc = SimpleDocTemplate(response, pagesize=A4,
                            rightMargin=2*cm, leftMargin=2*cm,
                            topMargin=2*cm, bottomMargin=2*cm)
    styles = getSampleStyleSheet()
    elementos = []

    # Encabezado
    header_data = [[
        Paragraph('<b><font size=18>Master Motors</font></b><br/>'
                  '<font size=9 color=grey>Taller Automotriz</font><br/>'
                  '<font size=8 color=grey>NIT: 900.123.456-7</font>', styles['Normal']),
        Paragraph('<font size=8 color=grey>'
                  'Cll 17 #12c-69, Gustavo Rojas Pinilla<br/>'
                  'Tel: 3184987478<br/>'
                  f'Fecha de emisión: {datetime.now().strftime("%d/%m/%Y %H:%M")}'
                  '</font>', styles['Normal']),
    ]]
    t_header = Table(header_data, colWidths=[9*cm, 10*cm])
    t_header.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('ALIGN', (1,0), (1,0), 'RIGHT'),
        ('LINEBELOW', (0,0), (-1,0), 1.5, colors.HexColor('#22c55e')),
        ('BOTTOMPADDING', (0,0), (-1,-1), 10),
    ]))
    elementos.append(t_header)
    elementos.append(Spacer(1, 0.5*cm))

    # Info factura
    info = [
        ['Factura N°:', f'#{invoice.id}', 'Estado:', invoice.status],
        ['Método de pago:', invoice.payment_method or '—', 'Generado por:', generado_por],
    ]
    t = Table(info, colWidths=[3.5*cm, 5.5*cm, 3.5*cm, 6.5*cm])
    t.setStyle(TableStyle([
        ('FONTNAME', (0,0), (-1,-1), 'Helvetica'),
        ('FONTNAME', (0,0), (0,-1), 'Helvetica-Bold'),
        ('FONTNAME', (2,0), (2,-1), 'Helvetica-Bold'),
        ('FONTSIZE', (0,0), (-1,-1), 9),
        ('BACKGROUND', (0,0), (-1,-1), colors.HexColor('#f0fdf4')),
        ('BOTTOMPADDING', (0,0), (-1,-1), 5),
        ('TOPPADDING', (0,0), (-1,-1), 5),
        ('GRID', (0,0), (-1,-1), 0.3, colors.HexColor('#dee2e6')),
    ]))
    elementos.append(t)
    elementos.append(Spacer(1, 0.5*cm))

    # Datos del cliente
    cedula = getattr(customer, 'cedula', None) or '—'
    cliente_data = [
        ['Nombre:', f'{customer.first_name} {customer.last_name}', 'Cédula:', str(cedula)],
        ['Teléfono:', customer.phone, 'Email:', customer.email],
        ['Vehículo:', f'{vehicle.brand} {vehicle.model}', 'Placa:', vehicle.plate],
        ['Mecánico:', f'{mechanic.first_name} {mechanic.last_name}', 'Orden N°:', f'#{workorder.id}'],
    ]
    t2 = Table(cliente_data, colWidths=[3.5*cm, 5.5*cm, 3.5*cm, 6.5*cm])
    t2.setStyle(TableStyle([
        ('FONTNAME', (0,0), (-1,-1), 'Helvetica'),
        ('FONTNAME', (0,0), (0,-1), 'Helvetica-Bold'),
        ('FONTNAME', (2,0), (2,-1), 'Helvetica-Bold'),
        ('FONTSIZE', (0,0), (-1,-1), 9),
        ('ROWBACKGROUNDS', (0,0), (-1,-1), [colors.HexColor('#f8f9fa'), colors.white]),
        ('GRID', (0,0), (-1,-1), 0.3, colors.HexColor('#dee2e6')),
        ('BOTTOMPADDING', (0,0), (-1,-1), 5),
        ('TOPPADDING', (0,0), (-1,-1), 5),
    ]))
    elementos.append(t2)
    elementos.append(Spacer(1, 0.5*cm))

    # Servicios
    if servicios.exists():
        elementos.append(Paragraph('<b>Servicios</b>', styles['Normal']))
        elementos.append(Spacer(1, 0.2*cm))
        data = [['Servicio', 'Precio']]
        for s in servicios:
            data.append([s.service.name, f'$ {s.service.price:,.0f}'])
        t3 = Table(data, colWidths=[13*cm, 6*cm])
        t3.setStyle(TableStyle([
            ('BACKGROUND', (0,0), (-1,0), colors.HexColor('#22c55e')),
            ('TEXTCOLOR', (0,0), (-1,0), colors.white),
            ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
            ('FONTNAME', (0,1), (-1,-1), 'Helvetica'),
            ('FONTSIZE', (0,0), (-1,-1), 9),
            ('ALIGN', (1,0), (1,-1), 'RIGHT'),
            ('ROWBACKGROUNDS', (0,1), (-1,-1), [colors.white, colors.HexColor('#f8f9fa')]),
            ('GRID', (0,0), (-1,-1), 0.3, colors.HexColor('#dee2e6')),
            ('BOTTOMPADDING', (0,0), (-1,-1), 5),
            ('TOPPADDING', (0,0), (-1,-1), 5),
        ]))
        elementos.append(t3)
        elementos.append(Spacer(1, 0.3*cm))

    # Repuestos
    if repuestos.exists():
        elementos.append(Paragraph('<b>Repuestos</b>', styles['Normal']))
        elementos.append(Spacer(1, 0.2*cm))
        data2 = [['Repuesto', 'Cantidad', 'Precio unit.']]
        for r in repuestos:
            data2.append([r.sparepart.name, str(r.quantity), f'$ {r.sparepart.price:,.0f}'])
        t4 = Table(data2, colWidths=[10*cm, 3*cm, 6*cm])
        t4.setStyle(TableStyle([
            ('BACKGROUND', (0,0), (-1,0), colors.HexColor('#22c55e')),
            ('TEXTCOLOR', (0,0), (-1,0), colors.white),
            ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
            ('FONTNAME', (0,1), (-1,-1), 'Helvetica'),
            ('FONTSIZE', (0,0), (-1,-1), 9),
            ('ALIGN', (1,0), (2,-1), 'RIGHT'),
            ('ROWBACKGROUNDS', (0,1), (-1,-1), [colors.white, colors.HexColor('#f8f9fa')]),
            ('GRID', (0,0), (-1,-1), 0.3, colors.HexColor('#dee2e6')),
            ('BOTTOMPADDING', (0,0), (-1,-1), 5),
            ('TOPPADDING', (0,0), (-1,-1), 5),
        ]))
        elementos.append(t4)
        elementos.append(Spacer(1, 0.3*cm))

    # Total
    elementos.append(Spacer(1, 0.3*cm))
    total_data = [['', 'TOTAL A PAGAR:', f'$ {invoice.total:,.0f}']]
    t5 = Table(total_data, colWidths=[9*cm, 5*cm, 5*cm])
    t5.setStyle(TableStyle([
        ('FONTNAME', (0,0), (-1,-1), 'Helvetica-Bold'),
        ('FONTSIZE', (1,0), (2,0), 12),
        ('ALIGN', (1,0), (2,0), 'RIGHT'),
        ('TEXTCOLOR', (2,0), (2,0), colors.HexColor('#22c55e')),
        ('LINEABOVE', (1,0), (2,0), 1, colors.HexColor('#22c55e')),
        ('TOPPADDING', (0,0), (-1,-1), 8),
    ]))
    elementos.append(t5)

    elementos.append(Spacer(1, 1*cm))
    elementos.append(Paragraph(
        '<font size=8 color=grey>Gracias por confiar en Master Motors. '
        'Este documento es válido como comprobante de servicio.</font>',
        styles['Normal']
    ))

    doc.build(elementos)
    return response
