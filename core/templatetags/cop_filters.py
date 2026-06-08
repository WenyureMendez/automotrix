from django import template

register = template.Library()

@register.filter
def cop(value):
    try:
        value = int(round(float(value)))
        return '$ {:,}'.format(value).replace(',', '.')
    except (ValueError, TypeError):
        return value