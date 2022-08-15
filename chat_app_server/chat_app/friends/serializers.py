from rest_framework import serializers
from .models import FriendList, FriendRequest
from django.contrib.auth import get_user_model
from rest_framework import status

User = get_user_model()


class SendFriendRequestSerializer(serializers.Serializer):
    sender_user = serializers.CharField()
    receiver_user = serializers.CharField()

    def validate(self, data):
        sender = data.get('sender_user')
        receiver = data.get('receiver_user')

        try:
            sender_user = User.objects.get(user_uid = sender)
        except:
            sender_user = None
        
        try:
            receiver_user = User.objects.get(user_uid = receiver)
        except:
            receiver_user = None

        if not sender_user or not receiver_user:
            raise serializers.ValidationError({'message': 'User(s) account does not exists.'}, code=status.HTTP_404_NOT_FOUND)

        try:
            friend_request = FriendRequest.objects.filter(sender=sender, receiver=receiver)
        except:
            friend_request = None

        for request in friend_request:
            if request.is_active:
                raise serializers.ValidationError({'message': 'Friend request already sent to the user.'}, code=status.HTTP_409_CONFLICT)
                
        return data


class ShowFriendRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = FriendRequest
        fields = '__all__'


FRIEND_REQUEST_CHOICE = (
    ('accept', 'Accept'),
    ('decline', 'Decline')
) 


class AcceptDeclineFriendRequestSerializer(serializers.Serializer):
    request_id = serializers.IntegerField()
    request_option = serializers.ChoiceField(choices=FRIEND_REQUEST_CHOICE)

    def validate(self, data):
        request_id = data.get('request_id')

        if not request_id:
            raise serializers.ValidationError({'message': "Friend request doesn't exists"}, code=status.HTTP_404_NOT_FOUND)

        return data

class CancelFriendRequestSerializer(serializers.Serializer):
    request_id = serializers.IntegerField()
    sender_user = serializers.CharField()
    receiver_user = serializers.CharField()

    def validate(self, data):
        try:
            request_id = data.get('request_id')
        except:
            request_id = None

        friend_request = FriendRequest.objects.get(id=request_id)

        if friend_request:
            if not friend_request.is_active:
                raise serializers.ValidationError({'message: "Friend request not found."'}, code=status.HTTP_404_NOT_FOUND)

        return request_id
