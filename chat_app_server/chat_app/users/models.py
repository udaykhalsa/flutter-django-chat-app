import uuid
from django.db import models
from django.contrib.auth.models import (
    AbstractBaseUser, AbstractUser, BaseUserManager
)


def user_profile_picture(instance, filename):
    image_extension = filename.split('.')[-1]
    image_name = f'user_profile_picture/{instance.user_uid}/{instance.user_uid}.{image_extension}'

    return image_name


class UserManager(BaseUserManager):
    def create_user(self, username, password=None, **extra_fields):
        if not username:
            raise ValueError('User must have a Username')

        user = self.model(username=username)
        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(self, username, password, **extra_fields):
        user = self.create_user(
            username, password=password
        )

        user.is_admin = True
        user.save(using=self._db)

        return user


class User(AbstractBaseUser):
    user_uid = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False)
    username = models.CharField(max_length=25, unique=True)
    profile_picture = models.ImageField(
        upload_to=user_profile_picture, null=True, blank=True)
    email_id = models.EmailField(verbose_name='Email ID', unique=True)
    name = models.CharField(max_length=100)
    about_me = models.CharField(
        max_length=256, default="Hey, I'm using this app.")
    phone_number = models.CharField(max_length=20, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_verified = models.BooleanField(default=False)

    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_admin = models.BooleanField(default=False)

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['email_id', 'name']

    def get_full_name(self):
        full_name = self.name
        return full_name

    def get_short_name(self):
        return self.name

    def __str__(self):
        return self.username

    def has_perm(self, perm):
        return True

    def has_module_perms(self, app_label):
        return True

    @property
    def is_staff(self):
        return self.is_admin

    objects = UserManager()
