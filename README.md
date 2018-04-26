API URL: http://boks-backands.herokuapp.com

Ruby on Rails training project

The purpose of this system are as follows:
1. User/Member:
 - Can enter details related to a particular book.
 - Can update, delete the book of his own creation.
2. Admin: 
 - Can read and write information about any member.
 - Can update, create, delete all of books
3. Addional features:
 - Pagination
 - Export to excel
 - Upload image

Usage:
1. Sessions
 - POST     /api/v2/members/sign_in
 - DELETE   /api/v2/members/sign_out
2. CRUD Books
 - POST     /api/v2/books
 - GET      /api/v2/books
 - GET      /api/v2/books/:id
 - PUT      /api/v2/books/:id
 - DELETE   /api/v2/books/:id
3. CRUD User (self-user)
 - POST     /api/v2/members
 - PUT      /api/v2/members
 - DELETE   /api/v2/members
4. User (admin)
 - GET      /api/v2/members/:id
 - GET      /api/v2/members
 - PATCH    /api/v2/members/:id
 - PUT      /api/v2/members/:id
 - DELETE   /api/v2/members/:id
5. Export xls file (developing)
 - GET      /api/v2/books/xls
 - GET      /api/v2/members/xls