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

## How it works?
![add](https://user-images.githubusercontent.com/82601472/209866043-3e58c8b0-53b2-4365-8acf-fb125d35fb67.png)   
![check](https://user-images.githubusercontent.com/82601472/209865045-88bd46b9-8b16-414a-b28b-3e8b0d32c8a1.png)   
![colors](https://user-images.githubusercontent.com/82601472/209866209-0daa503c-b540-4a9d-bb10-6b28238f7b2d.png)   

At first we have empty list, but a state of our application is remembering, 
so change the color or add new tasks will be remember by database and reading back in next open.

### Change the name of application?
My application was created with not that much pretty name, so I was change it to ,,To Do"   
![Zrzut ekranu 2022-11-17 225234](https://user-images.githubusercontent.com/82601472/209869992-62dfb569-e44a-460f-bbf2-b5788300828c.png)   
![318228250_559533229348441_8932234585893021539_n](https://user-images.githubusercontent.com/82601472/209869986-528be5bb-c101-4f0a-bef1-b6a4fea262f6.jpg)   

## Something to change in this app?
If you will see something to upgrade/improve, please write a comment :slightly_smiling_face:  
For now I want:
- [ ] Change init data to read from outside file
- [ ] Tranform lists to animated lists
