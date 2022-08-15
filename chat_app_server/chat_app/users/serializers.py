import email
from rest_framework import serializers
from rest_framework import status
from django.contrib.auth import get_user_model
import re

User = get_user_model()


def password_validator(password):
    if re.findall('[a-z]', password):
        if re.findall('[A-Z]', password):
            if re.findall('[0-9]', password):
                if re.findall("[~\!@#\$%\^&\*\(\)_\+{}\":;'\[\]]", password):
                    if len(password) > 7:
                        return True
    return False

def check_username(username):
    instagram_username_pattern = bool(re.match(r'^([A-Za-z0-9_](?:(?:[A-Za-z0-9_]|(?:\.(?!\.))){0,28}(?:[A-Za-z0-9_]))?)$', username))
    return instagram_username_pattern


class RegisterUserSerializer(serializers.Serializer):
    username = serializers.CharField(error_messages={'message': 'Username Required.'})
    email_id = serializers.EmailField(error_messages={'message': 'Username Required.'})
    name = serializers.CharField(error_messages={'message': 'Username Required.'})
    password = serializers.CharField(error_messages={'message': 'Username Required.'})
    confirm_password = serializers.CharField(error_messages={'message': 'Username Required.'})

    def validate(self, data):
        username = data.get('username')
        email_id = data.get('email_id')
        password = data.get('password')
        confirm_password = data.get('confirm_password')

        try:
            user = User.objects.get(username=username)
        except:
            user = None

        try:
            user_email = User.objects.get(email_id=email_id)
        except:
            user_email = None

        if user:
            raise serializers.ValidationError('User with given username already exists.')

        if user_email:
            raise serializers.ValidationError('Email ID already belongs to an account.')
            
        if not check_username(username):
            raise serializers.ValidationError('Not a valid username.')

        if not password or not confirm_password:
            raise serializers.ValidationError("Please provide all details.")

        if not password_validator(password):
            raise serializers.ValidationError('Password must contain 1 number, 1 upper-case and lower-case letter and a special character.')

        if password == email_id:
            raise serializers.ValidationError('Password cannot be your Email ID.')

        if password != confirm_password:
            raise serializers.ValidationError('Password fields did not match.')

        return data

class LoginUserSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        username = data.get('username')
        password = data.get('password')

        try:
            user = User.objects.get(username=username)
        except:
            user = None

        if not user:
            raise serializers.ValidationError({'message': 'Account with username does not exists.'}, code=status.HTTP_404_NOT_FOUND)

        if not user.check_password(password):
            raise serializers.ValidationError({'message': 'Password is incorrect.'}, code=status.HTTP_401_UNAUTHORIZED)
        
        # if not user.is_verified:
        #     raise serializers.ValidationError('User is not verified.')
        
        if not user.is_active:
            raise serializers.ValidationError('User is not active.')

        return data


        


