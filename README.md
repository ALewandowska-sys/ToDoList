# ToDoList
First application in Flutter to manage tasks (insert, delete, update) using database.

## Database
#### Moor -> drift
I started this app with moor database, but during programming I decide to upgrade it to drift and it's very easy!   
Only one line code inside terminal: `flutter pub run moor_generator migrate`  
Of course don't forget about necessary dependencies
#### Why drift?
- I prefered relationship database, because it's more clearly for me, so I was glad that tasks it's easy to construct like table.    
I saw many solutions of To Do app with no-relationship DB like Hive too. It's show that this easy application can be created on different base and every of it will be good.    
- I tred use SQLite, but .. this meeting doesn't be very fruitful :woozy_face:  
- I found a great webside with information about migration, etc. so catch [link](https://drift.simonbinder.eu/docs/advanced-features/migrations/)!
- SQL query only for unusual query :sunglasses:
#### Miles stones using drift
- Create database with 2 tables. It wasn't easy to find example with more than one table in database, what suprise me.
<!-- show how -->
- Create initial data for `ThemeColor`. It's still to improve, because at now it's code inside database declaration.
<!-- show how -->

## Something to change in this app?
If you will see something to upgrade/improve, please write a comment :slightly_smiling_face:  
For now I want:
- [ ] Change init data to read from outside file
- [ ] Tranform lists to animated lists
