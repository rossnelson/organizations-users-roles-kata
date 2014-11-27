
## The Organizations - Users - Roles kata

![Kata: http://www.planoaikido.com/](http://cl.ly/image/0c1T1b1A0K1b/Jo-Kata-14-Strikes-small2.jpg)

We have three layers of organizations: root organization, organizations and child organizations.

There is only one root organization that we call "Root Org".  
Organizations have one parent.  
The parent of all organizations is the Root Org.  
The organizations can have any number of child organizations, but the child orgs do not have children of their own (they are leaves).  

There are three different roles in the system:

- Admin
- User
- Denied

Roles are inherited through the organization hierarchy: an admin to an organization is an admin to all of its child organizations as well. For example - using the organization structure in the diagram above - if I have admin role access to Org 1, than I should have admin access to Child Org 1 and Child Org 2.

If a role is specified to a child org for a given user, that role takes precedence over the inherited role from the organization level.
When I have the "denied" role for Child Org 2, than I only have admin access to Org 1 and Child Org 1 and I don't even see Child Org 2.

> [Source: Climb That Mountain](http://www.adomokos.com/2012/10/the-organizations-users-roles-kata.html)
