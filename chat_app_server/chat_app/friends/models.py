from webbrowser import get
from django.db import models
from django.contrib.auth import get_user_model
from django.utils import timezone

User = get_user_model()

class FriendList(models.Model):
	user    = models.OneToOneField(User, on_delete=models.CASCADE, related_name="user")
	friends = models.ManyToManyField(User, blank=True, related_name="friends") 

	def __str__(self):
		return self.user.username

	def add_friend(self, account):
		"""
		Add a new friend.
		"""
		if not account in self.friends.all():
			self.friends.add(account)
			self.save()

	def remove_friend(self, account):
		"""
		Remove a friend.
		"""
		if account in self.friends.all():
			self.friends.remove(account)

	def unfriend(self, removee):
		"""
		Initiate the action of unfriending someone.
		"""
		remover_friends_list = self # person terminating the friendship

		# Remove friend from remover friend list
		remover_friends_list.remove_friend(removee)

		# Remove friend from removee friend list
		friends_list = FriendList.objects.get(user=removee)
		friends_list.remove_friend(remover_friends_list.user)


	def is_mutual_friend(self, friend):
		"""
		Is this a friend?
		"""
		if friend in self.friends.all():
			return True
		return False


class FriendRequest(models.Model):
	"""
	A friend request consists of two main parts:
		1. SENDER
			- Person sending/initiating the friend request
		2. RECIVER
			- Person receiving the friend friend
	"""

	sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name="sender")
	receiver = models.ForeignKey(User, on_delete=models.CASCADE, related_name="receiver")

	is_active = models.BooleanField(blank=False, null=False, default=True)

	timestamp = models.DateTimeField(auto_now_add=True)

	def __str__(self):
		return self.sender.username

	def accept(self):
		"""
		Accept a friend request.
		Update both SENDER and RECEIVER friend lists.
		"""
		receiver_friend_list = FriendList.objects.get_or_create(user=self.receiver)
		print(receiver_friend_list[0])
		if receiver_friend_list:
			receiver_friend_list[0].add_friend(self.sender)
			sender_friend_list = FriendList.objects.get_or_create(user=self.sender)
			if sender_friend_list:
				sender_friend_list[0].add_friend(self.receiver)
				self.is_active = False
				self.save()

	def decline(self):
		"""
		Decline a friend request.
		Is it "declined" by setting the `is_active` field to False
		"""
		self.is_active = False
		self.save()


	def cancel(self):
		"""
		Cancel a friend request.
		Is it "cancelled" by setting the `is_active` field to False.
		This is only different with respect to "declining" through the notification that is generated.
		"""
		self.is_active = False
		self.save()