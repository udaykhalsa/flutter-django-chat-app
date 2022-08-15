from django.urls import path
from .views import RegisterUserView, LoginUserView, LogoutUserView

urlpatterns = [
    path('api/v1/signup/', RegisterUserView.as_view(), name='user_register'),

    path('api/v1/login/', LoginUserView.as_view(), name='user_login'),
    path('api/v1/logout/', LogoutUserView.as_view(), name='user_logout'),
]
