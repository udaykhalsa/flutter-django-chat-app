from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()


class ChatParticipantsChannel(models.Model):
    channel = models.CharField(max_length=256)
    user = models.ForeignKey(User, on_delete=models.PROTECT)

    def __str__(self):
        return str(self.channel)


class ChatRoom(models.Model):
    name = models.CharField(max_length=256)
    last_message = models.CharField(max_length=1024, null=True)
    last_sent_user = models.ForeignKey(
        User, on_delete=models.PROTECT, null=True)

    def __str__(self):
        return self.name


class Messages(models.Model):
    room = models.ForeignKey(ChatRoom, on_delete=models.PROTECT)
    user = models.ForeignKey(User, on_delete=models.PROTECT)
    content = models.CharField(max_length=1024)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.content


class ChatRoomParticipants(models.Model):
    user = models.ForeignKey(User, on_delete=models.PROTECT)
    room = models.ForeignKey(ChatRoom, on_delete=models.PROTECT)
