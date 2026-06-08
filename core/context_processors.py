def roles(request):
    if request.user.is_authenticated:
        return {
            'is_admin': request.user.is_superuser or request.user.groups.filter(name='Administrador').exists(),
            'is_recepcionista': request.user.is_superuser or request.user.groups.filter(name__in=['Administrador', 'Recepcionista']).exists(),
            'is_mecanico': request.user.is_superuser or request.user.groups.filter(name__in=['Administrador', 'Mecánico']).exists(),
        }
    return {'is_admin': False, 'is_recepcionista': False, 'is_mecanico': False}