from django.contrib import admin
from .models import ChatRoom, Messages, ChatParticipantsChannel, ChatRoomParticipants


admin.site.register(ChatRoomParticipants)
admin.site.register(ChatRoom)
admin.site.register(Messages)
admin.site.register(ChatParticipantsChannel)
