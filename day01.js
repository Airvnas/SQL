show dbs
db
//mydb 데이터베이스 생성
use mydb
db
show dbs
//mydb에 collection을 생성해보자.
db.createCollection("employees",{capped:true,size:10000})
//capped:true ==>저장공간이 차면 기존 공간을 재사용하겠다는 설정
db
show collections
show dbs
db.employees.find()
db.employees.isCapped()
db.employees.stats()

db.employees.renameCollection("emp")
show collections
//컬렉션 삭제 db.컬렉션명.drop()
db.emp.drop()
show collections

//collection 생성
db.createCollection("cappedCollection",{capped:true,size:10000})
//capped:true => 최초 제한된 크기로 생성된 공간에서만 데이터를 저장하는 설정
//size:10000 =>10000보다 크면서 가장 가까운 256배수로 maxsize가 설정됨 10240
show collections

db.cappedCollection.find()
db.cappedCollection.stats()

//도큐먼트(row)를 size초과하도록 반복문 이용해서 넣어보자
for(i=0;i<1000;i++){
     db.cappedCollection.insertOne({x:i})   
}

db.cappedCollection.find()
db.cappedCollection.find().count()

db.cappedCollection.isCapped()

/*[1]Create : insertOne()
               -insertOne():한개의 document 생성
               -isnertMany([{},{},{}]):여러개의 document생성
              db.emp.insertOne({ <---collection(table)
                  id:'a001',     <---field---+ (column)
                  name:'james',  <---field---+---document(record)
                  dept:'Sales'   <---field---+
              
              })
*/
use mydb
db
db.createCollection('member')
show collections

db.member.find()
db.getCollection('member').find()

db.member.insertOne({
    name:'김민준',
    userid:'min',
    tel:'010-2222-3333',
    age:20
})
db.member.find()
/*
   _id 필드가 자동으로 생성된다. document에 유일성을 보장하는 키
   전체 : 12bytes
          4bytes:현재 timestamp=>문서 생성시점
          3bytes:machine id
          2bytes:몽고디비 프로세스 id
          3bytes:일련번호
*/
db.member.insertOne({
    _id:1,//비권장
    name:'홍길동',
    userid:'hong',
    tel:'010-2221-4445',
    age:22
})
db.member.find()
//document를 bson으로 변환하여 몽고디비에 저장
//_id: 자동으로 index가 생성된다==>검색을 빠르게 할 수있다.중복저장 불가

db.member.insertMany([
    {name:'이민수',userid:'Lee',age:23},
    {name:'최민수',userid:'Choi',tel:'010-9999-2222',age:26},
    {name:'유재석',userid:'Yoo',tel:'010-4832-4983',age:21}
])

db.member.find()

db.member.insertOne({name:'표진우',userid:'Pyo',passwd:'123',grade:'A'})

db.user.insertMany([
    {_id:1,name:'김철',userid:'kim1',passwd:'1111'},
    {_id:2,name:'최철',userid:'choi1',passwd:'2222'}
])
db.user.find()
db.user.insertMany([
    {_id:3,name:'김철',userid:'kim1',passwd:'1111'},
    {_id:2,name:'최철',userid:'choi1',passwd:'2222'},
    {_id:4,name:'최철',userid:'choi1',passwd:'2222'}
],{ordered:false})
//ordered옵션의 기본값 true. 순서대로 insert할지 여부를 지정
//false를 주면 순서대로 입력하지않음
//=>_id중복되어도 그 이후의 데이터를 삽입

/*
[실습1]---------------------------------------------------------------------
1. boardDB생성
2. board 컬렉션 생성
3. board 컬렉션에 name 필드값으로 "자유게시판"을 넣어본다
4. article 컬렉션을 만들어 document들을 삽입하되,
   bid필드에 3에서 만든 board컬렉션 자유게시판의 _id값이 참조되도록 처리해보자.

5. 똑 같은 방법으로 "공지사항게시판"을 만들고 그 안에 공지사항 글을 작성하자.
--------------------------------------------------------------------------
*/
use boardDB
db
db.board.drop()
db.article.drop()

freeboard_res=db.board.insertOne({name:'자유게시판'})
//freeboard_res에는 자유게시판 도큐먼트의 _id 값이 담긴다.

freeboard_id=freeboard_res.insertedId

db.article.insertMany([
    {bid:freeboard_id,title:'자유게시판 첫번째 글',content:'안녕하세요~',writer:'kim'},
    {bid:freeboard_id,title:'자유게시판 두번째 글',content:'반가워요~',writer:'choi'},
    {bid:freeboard_id,title:'자유게시판 세번째 글',content:'Hello!',writer:'lee'}
])

db.article.find()

notice_res=db.board.insertOne({name:'공지사항게시판'})
notice_id=notice_res.insertedId

db.noticeBoard.drop()
db.notice.insertMany([
    {bid:notice_id,title:'공지사항 글입니다.',writer:'admin',context:'공지글입니다.'},
    {bid:notice_id,title:'모임공지 글입니다.',writer:'admin',context:'6시 강남역'}
])

db.notice.find()
db.article.find()

/*R:read 조회
    -findOne(): 매칭되는 1개의 document를 조회
    -find(): 매칭되는 document list조회
    find({조건},{필드들})
*/
use mydb
db.member.find()
//select * from member
arr=db.member.find().toArray()
//모든 문서를 배열로 반환
arr[0]
arr[1]

db.member.find()
//member에서 name, tel만 조회하고 싶다면
db.member.find({},{name:true,tel:true,_id:false})
//select name,tel from member

db.member.find({},{name:1,tel:1,_id:0})
//위 문장과 동일 true=>1, false=>0으로 호환가능

//select * from member where age=20
db.member.find({age:20},{})

db.member.find({age:22},{name:1,userid:1,age:1,_id:0})

db.member.find({userid:"Yoo",age:21},{})

//select * from member where age=20 or userid='Yoo'
db.member.find({$or:[{userid:'Yoo'},{age:21}]},{})


//<1> userid가 'Choi'인 회원의 name,userid, tel 만 가져오기
///<2> age가 21세 이거나 userid가 'Lee'인 회원정보 가져오기
//<3> 이름이 이민수 이면서 나이가 23세인 회원정보 가져오기
db.member.find({userid:'Choi'},{name:1,userid:1,tel:1})
db.member.find({$or:[{age:21},{userid:'lee'}]},{})
db.member.find({name:'이민수',age:23},{})
db.member.find({$and:[{name:'이민수'},{age:23}]})
db.member.find()
//논리연산
//$or    :배열 안 두개 이상의 조건중 하나라도 참인경우를 반환
//$and   :배열 안 두개 이상의 조건이 모두 참인경우를 반환
//$nor   :$or의 반대. 배열 안 두개 이상의 조건중 모두 아닌 경우를 반환

/*
[실습2]
1. emp Collection 생성 {capped:true, size:100000} Capped Collection, size는 100000 으로 생성
2. scott계정의 emp레코드를 mydb의 emp Document 데이터로 넣기 
  => insertOne()으로 3개 문서 삽입, 
     insertMany로 나머지 문서 삽입해보기
*/
db.emp.drop()
db.emp.find()
db.createCollection("emp",{capped:true,size:100000})
db.emp.insertOne({EMPNO:7369,ENAME:'SMITH',JOB:'CLERK',MGR:'7902',HIREDATE:'80/12/17',SAL:800,COMM:null,DEPTNO:20})
db.emp.insertOne({EMPNO:7499,ENAME:'ALLEN',JOB:'SALESMAN',MGR:'7698',HIREDATE:'81/02/20',SAL:1600,COMM:300,DEPTNO:10})
db.emp.insertOne({EMPNO:7521,ENAME:'WARD',JOB:'SALESMAN',MGR:'7698',HIREDATE:'81/02/22',SAL:1250,COMM:500,DEPTNO:30})
db.emp.insertMany([
    {EMPNO:7566,ENAME:'JONES',JOB:'MANAGER',MGR:'7839',HIREDATE:'81/04/02',SAL:2975,COMM:null,DEPTNO:20},
    {EMPNO:7654,ENAME:'MARTIN',JOB:'SALESMAN',MGR:'7698',HIREDATE:'81/09/28',SAL:1250,COMM:1400,DEPTNO:30},
    {EMPNO:7698,ENAME:'BLAKE',JOB:'MANAGER',MGR:'7839',HIREDATE:'81/05/01',SAL:2850,COMM:null,DEPTNO:30},    
    {EMPNO:7782,ENAME:'CLARK',JOB:'MANAGER',MGR:'7839',HIREDATE:'81/06/09',SAL:2450,COMM:null,DEPTNO:10},    
    {EMPNO:7788,ENAME:'SCOTT',JOB:'ANALYST',MGR:'7566',HIREDATE:'82/12/09',SAL:3000,COMM:null,DEPTNO:20},
    {EMPNO:7839,ENAME:'KING',JOB:'PRESIDENT',MGR:null,HIREDATE:'81/11/17',SAL:5000,COMM:null,DEPTNO:10},    
    {EMPNO:7844,ENAME:'TURNER',JOB:'SALESMAN',MGR:7698,HIREDATE:'81/09/08',SAL:1500,COMM:null,DEPTNO:30},    
    {EMPNO:7876,ENAME:'ADAMS',JOB:'CLERK',MGR:7788,HIREDATE:'83/01/12',SAL:1100,COMM:null,DEPTNO:20},
    {EMPNO:7900,ENAME:'JAMES',JOB:'CLERK',MGR:7698,HIREDATE:'81/12/03',SAL:950,COMM:null,DEPTNO:30},
    {EMPNO:7902,ENAME:'FORD',JOB:'ANALYST',MGR:7566,HIREDATE:'81/12/03',SAL:3000,COMM:null,DEPTNO:20},   
    {EMPNO:7934,ENAME:'MILLER',JOB:'CLERK',MGR:7782,HIREDATE:'82/01/23',SAL:1300,COMM:null,DEPTNO:10},
    {EMPNO:8000,ENAME:'TOM',JOB:'ALALYST',MGR:null,HIREDATE:'22/10/31',SAL:4500,COMM:null,DEPTNO:20} 
])










