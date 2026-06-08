from django.db import models


class Appointments(models.Model):
    TIPO_CHOICES = [
        ('Cita previa', 'Cita previa'),
        ('Llegada directa', 'Llegada directa'),
    ]
    STATUS_CHOICES = [
        ('Pendiente', 'Pendiente'),
        ('En proceso', 'En proceso'),
        ('Finalizada', 'Finalizada'),
        ('Cancelada', 'Cancelada'),
    ]
    customer = models.ForeignKey('Customers', models.DO_NOTHING)
    vehicle = models.ForeignKey('Vehicles', models.DO_NOTHING)
    mechanic = models.ForeignKey('Mechanics', models.DO_NOTHING, blank=True, null=True)
    appointment_date = models.DateTimeField()
    reason = models.CharField(max_length=255, blank=True, null=True)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='Pendiente')
    tipo = models.CharField(max_length=20, choices=TIPO_CHOICES, default='Cita previa')
    workorder = models.ForeignKey('Workorders', models.SET_NULL, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'appointments'


class Customers(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    cedula = models.CharField(max_length=20, unique=True, blank=True, null=True)
    phone = models.CharField(max_length=20)
    email = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'customers'


class Insurances(models.Model):
    company_name = models.CharField(max_length=100)
    policy_number = models.CharField(max_length=50)
    start_date = models.DateField()
    end_date = models.DateField()
    vehicle = models.OneToOneField('Vehicles', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'insurances'


class Invoices(models.Model):
    STATUS_CHOICES = [
        ('Pendiente', 'Pendiente'),
        ('Pagada', 'Pagada'),
    ]
    PAYMENT_METHOD_CHOICES = [
        ('Efectivo', 'Efectivo'),
        ('Transferencia', 'Transferencia'),
    ]
    date = models.DateField()
    total = models.DecimalField(max_digits=10, decimal_places=2)
    workorder = models.ForeignKey('Workorders', models.DO_NOTHING)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='Pendiente')
    payment_method = models.CharField(max_length=20, choices=PAYMENT_METHOD_CHOICES, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'invoices'


class Mechanics(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    specialty = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'mechanics'


class Payments(models.Model):
    STATUS_CHOICES = [
        ('Pendiente', 'Pendiente'),
        ('Pagado', 'Pagado'),
    ]
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_date = models.DateField()
    method = models.CharField(max_length=20)
    invoice = models.ForeignKey(Invoices, models.DO_NOTHING)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='Pendiente')

    class Meta:
        managed = False
        db_table = 'payments'


class Services(models.Model):
    name = models.CharField(max_length=100)
    price = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        managed = False
        db_table = 'services'


class Spareparts(models.Model):
    name = models.CharField(max_length=50)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    stock = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'spareparts'


class Vehicles(models.Model):
    customer = models.ForeignKey(Customers, models.DO_NOTHING)
    brand = models.CharField(max_length=120)
    model = models.CharField(max_length=50)
    plate = models.CharField(max_length=20)
    problem = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'vehicles'


class Workorders(models.Model):
    vehicle = models.ForeignKey(Vehicles, models.DO_NOTHING)
    mechanic = models.ForeignKey(Mechanics, models.DO_NOTHING)
    status = models.CharField(max_length=15)
    start_date = models.DateField()
    end_date = models.DateField(blank=True, null=True)
    notas_mecanico = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'workorders'


class Workorderservices(models.Model):
    workorder = models.ForeignKey(Workorders, models.DO_NOTHING)
    service = models.ForeignKey(Services, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'workorderservices'


class Workorderspareparts(models.Model):
    workorder = models.ForeignKey(Workorders, models.DO_NOTHING, blank=True, null=True)
    sparepart = models.ForeignKey(Spareparts, models.DO_NOTHING, blank=True, null=True)
    quantity = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'workorderspareparts'