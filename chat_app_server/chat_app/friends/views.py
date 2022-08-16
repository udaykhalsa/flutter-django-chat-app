from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated

from django.http import JsonResponse
from django.db.models import Q
from django.contrib.auth import get_user_model

from .models import FriendList, FriendRequest
from .serializers import (SendFriendRequestSerializer, ShowFriendRequestSerializer,
                          AcceptDeclineFriendRequestSerializer, CancelFriendRequestSerializer)

User = get_user_model()


class SearchUserRequestView(APIView):
    permission_classes = (IsAuthenticated,)

    def get(self, request, username):
        users = User.objects.filter(
            Q(username__contains=username) | Q(username=username)).values('username', 'name', 'profile_picture', 'user_uid')

        response_content = {
            'status': True,
            'message': 'Searched Users.',
            'data': users
        }

        return Response(response_content)


class SendFriendRequestView(APIView):
    permission_classes = (IsAuthenticated,)
    serializer_class = SendFriendRequestSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        if serializer.is_valid():
            sender_user = serializer.validated_data['sender_user']
            receiver_user = serializer.validated_data['receiver_user']

            sender = User.objects.get(user_uid=sender_user)
            receiver = User.objects.get(user_uid=receiver_user)

            friend_request = FriendRequest.objects.create(
                sender=sender,
                receiver=receiver

            )
            friend_request.is_active = True
            friend_request.save()

            content = {
                'sender': sender.username,
                'receiver': receiver.username,
                'friend_request': friend_request.is_active
            }

            response_content = {
                'status': True,
                'message': 'Friend request sent sucessfully.',
                'data': content
            }

            return Response(response_content, status=status.HTTP_201_CREATED)
        else:
            response_content = {
                'status': False,
                'message': 'Unable to send request',
                'data': serializer.errors
            }
            try:
                return Response(response_content, status=serializer.errors['message'][0].code)
            except:
                return Response(response_content, status=status.HTTP_400_BAD_REQUEST)


class ShowFriendRequestView(APIView):
    permission_classes = (IsAuthenticated,)
    serializer_class = ShowFriendRequestSerializer

    def get(self, request):
        user = request.user
        friend_requests = FriendRequest.objects.filter(
            receiver=user, is_active=True)

        friend_request_data = list(friend_requests.values(
            'id', 'sender__user_uid', 'sender__username', 'sender__name', 'sender__about_me', 'sender__profile_picture'))

        response_content = {
            'status': True,
            'message': 'All friend requests.',
            'data': friend_request_data
        }

        return Response(response_content, status=status.HTTP_200_OK)


class AcceptDeclineFriendRequestView(APIView):
    permission_classes = (IsAuthenticated,)
    serializer_class = AcceptDeclineFriendRequestSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)

        print(request.data)

        if serializer.is_valid(raise_exception=True):
            try:
                request_id = request.data.get('request_id')
                request_option = request.data.get('request_option')

                print(request_id, request_option)

                friend_request = FriendRequest.objects.get(id=request_id)

                if request_option == 'accept':
                    friend_request.accept()

                    content = {
                        'id': friend_request.id,
                        'sender': friend_request.sender.username,
                        'receiver': friend_request.receiver.username,
                    }

                    response_content = {
                        'status': True,
                        'message': 'Request accepted sucessfully.',
                        'data': content
                    }
                    friend_request.is_active = False
                    return Response(response_content, status=status.HTTP_200_OK)

                elif request_option == 'decline':
                    friend_request.decline()

                    content = {
                        'id': friend_request.id,
                        'sender': friend_request.sender.username,
                        'receiver': friend_request.receiver.username,
                    }

                    response_content = {
                        'status': True,
                        'message': 'Request accepted sucessfully.',
                        'data': content
                    }
                    friend_request.is_active = False
            except Exception as e:
                response_content = {
                    'status': False,
                    'message': 'Unable to perform action.',
                    'data': serializer.errors
                }
                try:
                    return Response(response_content, status=serializer.errors['message'][0].code)
                except:
                    return Response(response_content, status=status.HTTP_400_BAD_REQUEST)
        else:
            response_content = {
                'status': False,
                'message': 'Unable to perform action.',
                'data': serializer.errors
            }
            print(response_content)
            try:
                return Response(response_content, status=serializer.errors['message'][0].code)
            except:
                return Response(response_content, status=status.HTTP_400_BAD_REQUEST)


class CancelFriendRequestView(APIView):
    permission_classes = (IsAuthenticated,)
    serializer_class = CancelFriendRequestSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)

        if serializer.is_valid():
            request_id = request.data.get('request_id')

            friend_request = FriendRequest.objects.get(id=request_id)
            friend_request.delete()

            content = {
                'id': friend_request.id,
                'sender': friend_request.sender.username,
                'receiver': friend_request.receiver.username,
            }

            response_content = {
                'status': True,
                'message': 'Friend request cancelled sucessfully.',
                'data': content
            }

            return Response(response_content, status=status.HTTP_200_OK)

        else:
            response_content = {
                'status': False,
                'message': 'Unable to perform action.',
                'data': serializer.errors
            }

            try:
                return Response(response_content, status=serializer.errors['message'][0].code)
            except:
                return Response(response_content, status=status.HTTP_400_BAD_REQUEST)


class ShowAllFriends(APIView):
    permission_classes = (IsAuthenticated,)

    def get(self, request):
        user = request.user

        try:
            user_friends = FriendList.objects.get(user=user)
        except:
            user_friends = None

        if user_friends:
            user_friends = list(user_friends.friends.all().values(
                'user_uid', 'username', 'profile_picture', 'name', 'about_me'))

            response_content = {
                'status': True,
                'message': 'All Friends',
                'data': user_friends
            }

            return JsonResponse(response_content, safe=False)
        else:
            response_content = {
                'status': False,
                'message': 'No friends found.',
                'data': [],
            }
            return Response(response_content, status=status.HTTP_200_OK)


class UserProfileInfo(APIView):
    permission_classes = (IsAuthenticated,)

    def get(self, request, user_uid):
        try:
            authenticated_user = request.user

            profile_user = User.objects.get(user_uid=user_uid)

            try:
                friend_list_user = FriendList.objects.get(
                    user=authenticated_user)
            except:
                friend_list_user = None

            user_friend = False

            content = {
                'user_uid': profile_user.user_uid,
                'username': profile_user.username,
                'name': profile_user.name,
                'about_me': profile_user.about_me,
                'profile_picture': profile_user.profile_picture.url if profile_user.profile_picture != '' else None,
                'is_friend': False,
                'sender': False,
                'receiver': False
            }

            if friend_list_user:
                if friend_list_user.is_mutual_friend(profile_user):
                    user_friend = True

                    content['is_friend'] = True

                    response_content = {
                        'status': True,
                        'message': 'User Profile Data',
                        'data': content
                    }
                    return Response(response_content, status=status.HTTP_200_OK)

            if not user_friend:
                try:
                    friend_request_sender = FriendRequest.objects.filter(
                        sender=authenticated_user, receiver=profile_user)
                except:
                    friend_request_sender = None

                if friend_request_sender:
                    content['sender'] = True

                    response_content = {
                        'status': True,
                        'message': 'User Profile Data',
                        'data': content
                    }

                    return Response(response_content, status=status.HTTP_200_OK)

            if not friend_request_sender:
                try:
                    friend_request_receiver = FriendRequest.objects.filter(
                        sender=profile_user, receiver=authenticated_user)
                except:
                    friend_request_receiver = None

                if friend_request_receiver:
                    content['receiver'] = True

                    response_content = {
                        'status': True,
                        'message': 'User Profile Data',
                        'data': content
                    }

                    return Response(response_content, status=status.HTTP_200_OK)

            response_content = {
                'status': True,
                'message': 'User Profile Data',
                'data': content
            }

            return Response(response_content, status=status.HTTP_200_OK)
        except Exception as e:
            return Response('yo', status=status.HTTP_400_BAD_REQUEST)
