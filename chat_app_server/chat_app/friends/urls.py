from django.urls import path
from .views import (SearchUserRequestView, SendFriendRequestView, ShowFriendRequestView, AcceptDeclineFriendRequestView,
                    CancelFriendRequestView, ShowAllFriends, UserProfileInfo)

urlpatterns = [
    path('api/v1/search-user/<str:username>', SearchUserRequestView.as_view(), name='search_user'),
    path('api/v1/send_friend_request/', SendFriendRequestView.as_view(), name='send_friend_request'),
    path('api/v1/friend-request-list/', ShowFriendRequestView.as_view(), name='show_friend_requests'),
    path('api/v1/friend_request_action/', AcceptDeclineFriendRequestView.as_view(), name='accept_decline_request'),
    path('api/v1/cancel_request/', CancelFriendRequestView.as_view(), name='cancel_request'),
    path('api/v1/friend-list/', ShowAllFriends.as_view(), name='cancel_request'),
    path('api/v1/user-profile-info/<str:user_uid>/', UserProfileInfo.as_view(), name='user-profile-info')
]
