"""Add an item to a shopping cart. Verify. Remove item. Verify."""
from seleniumbase import BaseCase


class MyTestClass(BaseCase):

    def test_basics(self):
        self.open("http://wp.doma/wp-login.php")
        self.type("#user_login", "title")
        self.type("#user_pass", "title")
        self.click("#wp-submit", timeout=1)
