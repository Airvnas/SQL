use mydb
show collections
db.inventory.find()
db.inventory.insertMany([
	{ item: "journal", qty: 25, tags: ["blank", "red"], dim_cm: [ 14, 21 ] },
	 { item: "notebook", qty: 50, tags: ["red", "blank"], dim_cm: [ 14, 21 ] },
	 { item: "paper", qty: 100, tags: ["red", "blank", "plain"], dim_cm: [ 14, 21 ] },
	 { item: "planner", qty: 75, tags: ["blank", "red"], dim_cm: [ 22.85, 30 ] },
	 { item: "postcard", qty: 45, tags: ["blue"], dim_cm: [ 10, 15.25 ] } 
	 ]);
db.inventory.find({tags:'blank'})
db.inventory.find({tags:['blank','red']})
db.inventory.find({tags:{$all:['blank','red']}})
db.inventory.find({tags:{$size:3}})
//dim_cm중 인덱스가 1번째인 값이 10보다 큰 상품들을 조회해서 출력
db.inventory.find({"dim_cm.1":{$gte:25}})

//#Update
/*    
    -updateOne({}) : 특정필드 값을 변경,증가,감소 시킬때
    -updateMany({}):
    -replaceOne({조건절},{대체할문서},{옵션}):도큐먼트 대체
*/
db.user.find()
db.user.replaceOne({_id:3},{'name':'김철수',userid:'kim22',passwd:'4444'})
db.user.replaceOne({userid:'hong'},{name:'홍길동',userid:'hong1',passwd:'1234'},{upsert:true})
//upsert옵션을 주면 조건에 해당하는 문서가 있으면 수정하고, 없으면 삽입함

db.user.updateOne({userid:'hong1'},{$set:{passwd:'abcd'}})
db.user.replaceOne({userid:'hong1'},{passwd:'1234'},{upsert:true})

db.user.updateOne({passwd:'1234'},{$set:{userid:'park',name:'박수'}})

/*도큐먼트 수정 연산자
    $set: 필드값 수정값으로 설장
    $inc: 필드값을 증가시키거나 감소시킴
        $inc:{age:1},$inc:{age:-2}
    $mul: 필드값에 곱하기를 수행
    $min: 필드값이 주어진 값보다 클  경우 새 값으로 교체
    $max: 필드값이 주어진 값보다 작을 경우 새 값으로 교체
    $currentDate:필드값을 현재 날짜로 수정(Date-디폴트,Timestamp)
        Timestamp를 이용하려면 $type연산자를 사용해야한다.
    $unset: 해당 필드를 제거한다.
    $rename: 필드명을 변경
*/
db.member.find()
//userid가 min인 사람의 나이를 1 증가시킴
db.member.updateOne({userid:'min'},{$inc:{age:1}})

db.member.updateMany({},{$set:{grade:'A'}})

//member에서 나이가 22세 이상인 회원의 등급을 'B'등급으로 수정하세요
db.member.updateMany({age:{$gte:22}},{$set:{grade:'B'}})

db.member.updateMany({grade:'A'},{$mul:{age:2}})

//grade가 A인 회원들의 나이가 20세보다 크면 20세로 수정
db.member.updateMany({grade:'A'},{$min:{age:20}})

//grade가 A인 회원들의 나이가 30세보다 크면 30세로 수정
db.member.updateMany({grade:'A'},{$min:{age:30}})

db.member.updateOne({userid:'Lee'},{$max:{age:30}})

db.member.updateMany({},{$currentDate:{indate:true}})
db.member.updateMany({},{$currentDate:{indate2:{$type:'timestamp'}}})
db.member.find()

//member에서 indate2를 제거
db.member.updateMany({},{$unset:{indate2:''}})

db.member.updateMany({},{$rename:{tel:'phone'}})

//#배열 수정
db.inventory.find()
/*
db.collection.updateMany({선택조건},
		{<update연산자>:{"<array>.$[<identifier>]":value}},
		{arrayFilters:[{<identifier>:<condition>}]}
		);
*/
db.inventory.find({item:'paper'})
//item이 paper인 상품의 tags배열에 있는 값중 'blank' 를 'blue'로 변경
db.inventory.updateMany({item:'paper'},{$set:{"tags.$[tagE]":'blue'}},{arrayFilters:[{tagE:'blank'}]})

//item이 postcard인 상품의 dim_cm에 있는 값 중에 10인 값을 12로수정
db.inventory.updateMany({item:'postcard'},{$set:{"dim_cm.$[dimE]":12}},{arrayFilters:[{dimE:10.0}]})

/*--배열 수정 연산자--------------------
[1] $addToSet: 배열에 해당 요소가 없으면 추가하고, 있으면 아무것도 하지 않음
[2] $pop: 배열에서 맨 앞 또는 맨 뒤를 꺼낸다. (java의 shift,pop을 합쳐놓은 연산자)
            {$pop:{필드:1,필드2:-1}}    -1=>shift (맨앞) 1=>pop(맨뒤)
[3] #pull: 배열에서 조건을 만족하는 특정 요소하나를 제거한다.
            {$pull:{조건1,조건2,...}}
[4] #pullAll:{$pullAll:{필드:[값1,값2,...]}}    
           
[5] #push: 배열에 새 요소를 추가함
            {$push:{필드:값}}
            배열을 push할 경우 배열안의 배열로 추가된다=>조심!@
            각각 따로 push하고싶다면
            {$push:{필드:{$each:배열}}}
*/

db.inventory.find()
db.inventory.updateMany({item:'journal'},{$addToSet:{tags:'gold'}})

//item이 journal인 상품의 tags에서 blank를 삭제하세요
db.inventory.updateMany({item:'journal'},{$pop:{tags:-1}})
db.inventory.updateMany({item:'journal'},{$pop:{tags:1}})

//item이 paper인 상품의 tags에서 blue를 삭제
db.inventory.updateMany({item:'paper'},{$pull:{tags:'blue'}})
db.inventory.find({item:'paper'})
db.inventory.find({item:'journal'})
//item이 paper인 상품의 tags에서 skyblue를 추가
db.inventory.updateMany({item:'paper'},{$push:{tags:'skyblue'}})

db.inventory.updateMany({item:'paper'},{$pullAll:{tags:['red','skyblue']}})

db.inventory.updateMany({item:'paper'},{$push:{tags:['yellow','pink']}})//객체로 들어감 (주의)
db.inventory.updateMany({item:'journal'},{$push:{tags:{$each:['yellow','pink']}}})

/*#[4] Delete
    -deleteOne()
    -deleteMany()
*/
db.member.find()
db.member.deleteMany({age:20})
db.member.deleteOne({grade:'B'})

//inventory에서 수량이 30개미만인 상품을 삭제
db.inventory.find({qty:{$lt:30}})

db.inventory.deleteOne({qty:{$lt:30}})

use boardDB
show collections
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

db.noticeBoard.find()
db.board.find()
db.board.insertOne({name:'비밀게시판'})
db.article.find()
//2
db.article.insertOne({bid:'638da08abb72f66b79ab469b',title:'자유게시판-실습1',content:'Hi',writer:'jy'})
db.article.insertOne({bid:'638da08abb72f66b79ab469b',title:'자유게시판-실습2',content:'aloha',writer:'sh'})
db.article.insertOne({bid:'638da08abb72f66b79ab469b',title:'자유게시판-실습3',content:'댓글이 달린글',
    comment:[{subject:'댓글 제목',re:'댓글내용',writer2:'글쓴이'}],writer:'gd'})
//3,4
db.secret.insertOne({bid:'639051fc7ec58050a4c6661b',title:'비밀글입니다.',content:'비밀',writer:'noname'})
db.secret.find()
//5,6
db.secret.updateOne({},{$inc:{upvote:1}},{upsert:true})
//7
db.article.deleteOne({title:'자유게시판-실습3'})
db.article.updateOne({title:'자유게시판-실습3'},{$push:{comment:{subject:'댓글추가',re:'222',writer2:'글쓴이2'}}})
db.article.updateOne({'comment.re':'222'},{$set:{upvote:0}})
db.article.find({'comment.re':'222'})

