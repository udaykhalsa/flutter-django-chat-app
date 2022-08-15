from django.contrib import admin
from .models import FriendList, FriendRequest

class FriendListAdmin(admin.ModelAdmin):
    list_display = ['user']
    search_fields = ['user']

admin.site.register(FriendList, FriendListAdmin)


class FriendRequestAdmin(admin.ModelAdmin):
    list_display = ['sender', 'receiver']
    search_fields = ['sender']

admin.site.register(FriendRequest, FriendRequestAdmin)