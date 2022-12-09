/*
------------------------------------------------------------------
[실습]
use boardDB
1. boardDB에서 작업한다
2. 자유게시판에 아무 글이나 2~3개 작성한다. 특히 그 중에 글 하나에는 
    댓글 하나가 달린 상태로 생성해본다. 댓글은 comment필드에 배열로 넣는다. comment[{제목},{글쓴이}]
3. 비밀게시판을 생성한다.
4. 비밀게시판에 작성자가 'noname'값을 가지는 글을 하나 작성한다.
5. 모든 글에 추천수 필드(upvote)를 추가하고 값을 0으로 설정한다
6. 비밀게시판 글에 추천수를 1 증가시킨다
7. 이미 댓글이 달린 자유게시판 글에 upvote 필드 없이 댓글을 추가한다.
8. 이미 댓글이 달린 글에 방금 달은 댓글에(특징을 기억해서 수정하자) 
    upvote 필드 값을 0으로 추가한다
==>배열요소값 수정 arraysFilters 파라미터 사용해보기.
------------------------------------------------------------------
*/
use boardDB
db.noticeBoard.find()
db.board.find()
db.board.insertOne({name:'비밀게시판'})
db.article.find()
db.article.find({bid:freeboard_id})
db.article.find({bid:secretboard_id})
//2
freeboard_id=db.board.find({name:'자유게시판'}).toArray()[0]._id
freeboard_id
db.article.insertOne({bid:freeboard_id,title:'자유게시판-실습1',content:'Hi',writer:'jy'})
db.article.insertOne({bid:freeboard_id,title:'자유게시판-실습2',content:'aloha',writer:'sh'})
db.article.insertOne({bid:freeboard_id,title:'자유게시판-실습3',content:'댓글이 달린글',
    comment:[{content:'댓글내용',writer:'글쓴이'}],writer:'gd'})
//3,4
db.board.deleteOne({name:'비밀게시판'})
secretboard_id=db.board.find({name:'비밀게시판'}).toArray()[0]._id
secretboard_id
db.article.deleteOne({bid:null})
db.article.insertOne({bid:secretboard_id,title:'비밀글입니다.',content:'비밀',writer:'noname'})
//5,6
db.secret.updateOne({},{$inc:{upvote:1}},{upsert:true})
//7
db.article.updateOne({title:'자유게시판-실습3'},{$push:{comment:{content:'댓글추가',writer:'글쓴이2'}}})
find_id=db.article.find({bid:freeboard_id,writer:'gd'}).toArray()[0]._id
find_id
db.article.updateOne({_id:find_id},{$set:{'comment.$[myele].upvote':0}},
                        {arrayFilters:[{'myele.writer':'글쓴이2'}]})
db.article.find()
//----------------------------------
db.article.deleteMany()
db.article.drop()
db.boarDB.drop()
db.dropDatabase()
//----------------------------------

/*
# 도큐먼트를 집계하는 방법은 3가지가 있다
[1] db의 모든 정보를 가져와 애플리케이션 단계에서 집계하는 방법
[2] 몽고디비의 맵리듀스 기능을 이용하는 방법
[3] 몽고디비의 집계 파이프라인 기능을 이용하는 방법
- 이 중에 파이프라인기능을 이용하는 방법이 처리 속도도 빠르고 램메모리 소요도 적게쓴다. 
   다만 자유도는 나쁜 편(주어진 연산자로만 가져오는데 때로 원하는 결과를 얻지 못할 수 있음)
- 집계 명령은 수많은 데이터를 처리해서 작은 양의 정보를 애플리케이션에 전달하는 특징이 있다.
  정보를 최대한 작게 만든후 앱으로 작아진 정보를 전송하는 것이 더 효율적임
- 많은양의 정보를 몽고디비 내부에서 처리한다면 많은 양의 램메모리가 필요하지 않게된다.
- 집계 파이프라인 명령어는 도큐먼트를 순차적으로 받아서 집계 처리를 몽고디비 내부에서 한다.
  맵리듀스 방식은 자바스크립트 엔진과 정보교환을 위해 램을 사용하는데 이때 대량의 메모리가 필요하게 된다.
  집계 파이프라인을 사용하는 것이 가장 합리적으로 보이지만,
  하지만 상황에 따라 맵리듀스로 처리해야 한다던지 애플리케이션에서 집계처리해야 할때도 있다.
*/
//#  집계 파이프라인 명령어
/*
$project : select절
$match: where절
$group: group by 절 => 사용하기 위해서는 _id값에 그룹화의 기준이 되는 값을 지정해야 한다.
$sort: order by 절
$limit
$unwind
*/

db
use mydb

db.articles.insertMany([
    { "author" : "john", "score" : 80, "views" : 100 },
    { "author" : "john", "score" : 85, "views" : 521 },
    { "author" : "ahn", "score" : 60, "views" : 1000 },
    { "author" : "li", "score" : 55, "views" : 5000 },
    { "author" : "annT", "score" : 60, "views" : 50 },
    { "author" : "li", "score" : 94, "views" : 999 },
    { "author" : "ty", "score" : 95, "views" : 1000 }
])
db.articles.find()

//select author,score from articles
//$project:{필드명1:1,필드명2:2,_id:0}
db.articles.aggregate([{$project:{_id:0,author:1,score:1}}])

//$match: 조건을 걸어서 가져올때
//select * from articles where score>80
db.articles.aggregate([{$match:{score:{$gt:80}}}])

//select * from articles where author='li' and score >=60
db.articles.aggregate([{$match:{score:{$gte:60},author:'li'}}])

//select author,sum(score) ac total from articles group by author
db.articles.aggregate([{
    $group:{_id:'$author',total:{$sum:'$score'}}
}])

//select author,sum(score) ac total from articles group by author having sum(score)>100
db.articles.aggregate([{
    $group:{_id:'$author',total:{$sum:'$score'}}},{$match:{total:{$gt:100}}
}])

//$sum $avg $min $max





