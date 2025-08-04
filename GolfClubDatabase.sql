use pkaur43


drop table UserTable
create table UserTable
(
   UserName varchar(10) primary key not null,
   Password varchar(15) not null
)

insert into UserTable
(UserName,Password)
values
('Gold1','12345')

insert into UserTable
(UserName,Password)
values
('Silver1','12345')


insert into UserTable
(UserName,Password)
values
('Bronze1','12345')

insert into UserTable
(UserName,Password)
values
('Gold2','12345')

insert into UserTable
(UserName,Password)
values
('Silver2','12345')

insert into UserTable
(UserName,Password)
values
('Bronze2','12345')

insert into UserTable
(UserName,Password)
values
('Gold3','12345')

insert into UserTable
(UserName,Password)
values
('Gold4','12345')


select * from Member
drop table Member
create table Member
(
   MemberNumber int identity(11,1) primary key not null,
   MemberName varchar(20) not null,
   MembershipLevel varchar(6) not null,
   PhoneNumber varchar(10) not null,
   UserName varchar(10) unique not null,
   MemberRole varchar(20) not null,
  
)
sp_help Member


select * from Member
select * from UserTable

insert into Member
(MemberName,MembershipLevel,PhoneNumber,UserName,MemberRole)
values
('Prabhjot Kaur','Gold','7800000000','Gold1','shareholder')

insert into Member
(MemberName,MembershipLevel,PhoneNumber,UserName,MemberRole)
values
('John Doe','Gold','7800000000','Gold2','Associate')


insert into Member
(MemberName,MembershipLevel,PhoneNumber,UserName,MemberRole)
values
('GoldMember1','Gold','7800200000','Gold3','shareholder')

insert into Member
(MemberName,MembershipLevel,PhoneNumber,UserName,MemberRole)
values
('GoldMember2','Gold','7800000001','Gold4','Associate')


insert into Member
(MemberName,MembershipLevel,PhoneNumber,UserName,MemberRole)
values
('Navdeep Sandhu','Silver','7801234564','Silver1','ShareholderSpouse')



insert into Member
(MemberName,MembershipLevel,PhoneNumber,UserName,MemberRole)
values
('Anmol','Silver','7801241236','Silver2','ShareholderSpouse')

insert into Member
(MemberName,MembershipLevel,PhoneNumber,UserName,MemberRole)
values
('BronzeMember1','Bronze','7808043245','Bronze1','Junior')

insert into Member
(MemberName,MembershipLevel,PhoneNumber,UserName,MemberRole)
values
('BronzeMember2','Bronze','7807043245','Bronze2','Junior')


select * from TeeTimes
drop table TeeTimes
create table TeeTimes
(
   GolfDate Date ,
   GolfDay varchar(9),
   GolfTime time(7),
   Member1Name varchar(20),
   Member2Name varchar(20),
   Member3Name varchar(20),
   Member4Name varchar(20),
   Member1Number int,
   Member2Number int,
   Member3Number int,
   Member4Number int,
    NoOfcarts int check(NoOfcarts>=0 and NoOfcarts<=4),
   BookingDate1 DateTime,
   BookingDate2 DateTime, 
   BookingDate3 DateTime,
   BookingDate4 DateTime,
    Member1CheckIn varchar(20),
   Member2CheckIn varchar(20),
   Member3CheckIn varchar(20),
   Member4CheckIn varchar(20)

    constraint FK_TeeTimes Foreign Key(Member1Number) references Member(MemberNumber),
	 constraint FK_TeeTimes1 Foreign Key(Member2Number) references Member(MemberNumber),
	  constraint FK_TeeTimes2 Foreign Key(Member3Number) references Member(MemberNumber),
	   constraint FK_TeeTimes3 Foreign Key(Member4Number) references Member(MemberNumber),
	constraint PK_TeeTimes Primary Key(GolfDate,GolfTime)
)

drop table StandingTeeTimeRequest
create table StandingTeeTimeRequest
(

    RequestNumber int identity(11,1),
	FirstMemberName varchar(20) not null,
	SecondMemberName varchar(20) not null,
	ThirdMemberName varchar(20) not null,
	ForthMemberName varchar(20) not null,
	FirstMemberNumber int primary key not null ,
	SecondMemberNumber int not null,
	ThirdMemberNumber int not null,
	ForthMemberNumber int not null,
	RequestedDay varchar(9) not null,
	RequestedTeeTime time not null,
	StartDate date not null,
	EndDate date not null,
	RequestTime datetime not null,
	RequestStatus varchar(15) not null

)

drop table MembershipApplications
create table MembershipApplications
(
    ApplicationNumber int identity(1,1) primary key not null,
    LastName varchar(20) not null,
	FirstName varchar(20) not null,
	Address varchar(50) not null,
	PostalCode varchar(6) not null,
	Phone varchar(10) not null,
	AlternatePhone varchar(10) null,
	Email varchar(50) not null,
	DateOfBirth date not null,
	Occupation varchar(50) not null,
	CompanyName varchar(50) not null,
	CompanyAddress varchar(50) not null,
	CompanyPostalCode varchar(6) not null,
	CompanyPhone varchar(10) not null,
	ApplicationDate date not null,
	OnlineSubmissionDate date not null,
	Shareholder1Name varchar(20) not null,
	Shareholder2Name varchar(20) not null,
	RequestedRole varchar(20) not null, 
	ApplicationStatus varchar(20) not null

)

drop table GolfGame
create table GolfGame
(
	GolfID int identity(1,1) primary key not null,
	MemberNumber int not null,
	GolfCourse varchar(25) not null,
	CourseRating decimal(5,2) not null,
	SlopeRating decimal(5,2) not null,
	GolfDate date not null,
	ScoreSubmissionDate date not null,
	TotalScore int null,
	ScoreDifferential decimal(5,2)  null
	)


drop table HoleScores
create table HoleScores
(
	HoleID int identity(1,1) primary key not null,
	GolfID int not null,
	HoleNumber int not null,
	HolePar int not null,
	HoleByHoleScore int not null
	constraint FK_HoleScores Foreign Key(GolfID) references GolfGame(GolfID)

)




drop table HoleScores

drop table PlayerHandicap
create table PlayerHandicap
(
  PlayerNumber int not null primary key,
  CalculationDate date  null,
  HandicapIndex decimal(5,2) null
)
sp_help PlayerHandicap


select * from GolfGame
drop table MemberAccount
create table MemberAccount
(
    AccountNumber int primary key not null,
	MemberNumber int not null,
	MemberName varchar(20) not null,
	Balance money null
)

drop table MemberAccountEntry
create table MemberAccountEntry
(
	AccountNumber int not null,
	TransactionNumber int identity(1,1) primary key not null,
	TransactionDescription varchar(50) not null,
	TransactionAmount decimal not null,
	WhenCharged datetime not null,
	WhenBooked datetime not null
	constraint FK_MemberAccountEntry Foreign Key(AccountNumber) references MemberAccount(AccountNumber)
)



GRANT EXECUTE ON AuthenticateLogin TO aspnetcore

--**************Login authentication ******************
create procedure AuthenticateLogin(@UserName varchar(10) =  null,
                                   @Password varchar(15) = null)
as
     declare @ReturnCode int
	 set @ReturnCode= 1

	 if @UserName is null
	    RAISERROR('Authenticate Login - Required Parameter : @UserName',16,1)
	 else
	    if @Password is null+
		 RAISERROR('Authenticate Login - Required Parameter : @Password',16,1)
		else
		  BEGIN
		  if exists(select *
		  from Member inner join UserTable on UserTable.UserName= @UserName and UserTable.Password= @Password
		  where UserTable.UserName=Member.UserName
		  )
		  begin
		  select MemberNumber, MemberName, MembershipLevel, PhoneNumber,Member.UserName,MemberRole
		  from Member inner join UserTable on UserTable.UserName= @UserName and UserTable.Password= @Password
		  where UserTable.UserName=Member.UserName
		  end

		  else
           begin
		   RAISERROR('Invalid Username or Password',16,1)
		   end
		   if @@ERROR = 0
			    set @ReturnCode = 0
		  END
		return @ReturnCode


execute AuthenticateLogin 'Gold1','12345'



GRANT EXECUTE ON SignUpOnline TO aspnetcore
drop procedure SignUpOnline
create procedure SignUpOnline(@MemberName varchar(20) = null,
						      @MemberNumber int = null,
							  @UserName varchar(20) = null,
							  @Password varchar(20) = null)
as
     declare @ReturnCode int
	 set @ReturnCode= 1
	 if @MemberName is null
		RAISERROR('SignUpOnline Error: MemberName is required',16,1)
	 if @MemberNumber is null
		RAISERROR('SignUpOnline Error: MemberNumber is required',16,1)
	 if @UserName is null
		RAISERROR('SignUpOnline Error: UserName is required',16,1)
	 if @Password is null
		RAISERROR('SignUpOnline Error: Password is required',16,1)
	 else
	 begin
	 if exists(select *
		  from Member 
		  where MemberName = @MemberName and MemberNumber = @MemberNumber and UserName = @UserName
		  )
		  begin
		  if not exists(
		  select *
		  from UserTable 
		  where UserName = @UserName
		  )
		  begin
		  insert into UserTable
		  (UserName, Password)
		  values
		  (@UserName, @Password)
		  end
		  else
		      RAISERROR('User already exists',16,1)
		  end
	      if @@ERROR = 0
			    set @ReturnCode = 0
	  end
	 return @ReturnCode

	 select * from Member
	 select * from TeeTimes
select * from UserTable
drop procedure GenerateTeeSheet
--********************GenerateTeeSheet ***********************
--create procedure GenerateTeeSheet
--as
-- declare @ReturnCode int
--	set @ReturnCode = 1
--	declare @hours int
--	set @hours = 7
--	declare @date Date
--	set @date=GETDATE()
--	declare @count int
--	set @count=1

--	while(@count<7)
--	begin
--	set @date=DATEADD(day,7,@date)
--	while(@hours<18)
--	begin
--	insert into TeeTimes
--	(GolfDate,GolfDay, GolfTime, NoOfcarts)
--	values
--	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':00',0),
--	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':07',0),
--	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':15',0),
--	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':22',0),
--	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':30',0),
--	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':37',0),
--	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':45',0),
--	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':52',0)
	
--	set @hours=@hours+1
--	end
	
--	set @count=@count+1

--	declare @RequestCount int
--	select @RequestCount = COUNT(*) from StandingTeeTimeRequest
--	declare @count1 int
--	set @count1=1


--	if @@ROWCOUNT > 0
--	begin
--	while(@count1<=@RequestCount)
--	begin
--	update TeeTimes 
--	set Member1Name = StandingTeeTimeRequest.FirstMemberName, Member1Number=StandingTeeTimeRequest.FirstMemberNumber, Member2Name = SecondMemberName, Member2Number=SecondMemberNumber, Member3Name=ThirdMemberName, Member3Number=ThirdMemberNumber,
--	    Member4Name=ForthMemberName, Member4Number=ForthMemberNumber
--	from StandingTeeTimeRequest
--	where StandingTeeTimeRequest.RequestStatus = 'Approved' and
--		  StandingTeeTimeRequest.RequestedDay = DATENAME(Weekday, @date) and
--	      StandingTeeTimeRequest.RequestedTeeTime = TeeTimes.GolfTime
		  

--	set @count1=@count1+1
--	end
	
--	end
--	end
	
--execute GenerateTeeSheet

GRANT EXECUTE ON GenerateTeeSheet TO aspnetcore
select * from TeeTimes
drop procedure GenerateTeeSheet
create procedure GenerateTeeSheet
as
 declare @ReturnCode int
	set @ReturnCode = 1
	declare @hours int
	set @hours = 7
	declare @date Date
	set @date=DATEADD(day,7,GETDATE())
	declare @count int
	set @count=1

		while(@count<7)
	begin
	--set @date=DATEADD(day,5,@date)
	while(@hours<18)
	begin
	insert into TeeTimes
	(GolfDate,GolfDay, GolfTime, NoOfcarts, Member1CheckIn, Member2CheckIn, Member3CheckIn, Member4CheckIn)
	values
	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':00',0, 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn'),
	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':07',0,'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn'),
	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':15',0, 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn'),
	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':22',0, 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn'),
	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':30',0, 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn'),
	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':37',0, 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn'),
	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':45',0, 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn'),
	(@date,  Datename(Weekday, @date),CAST(@hours as varchar)+':52',0, 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn', 'Waiting CheckIn')
	
	set @hours=@hours+1
	end
	set @count = @count + 1

	declare @FirstMemberName varchar(20), @SecondMemberName varchar(20), @ThirdMemberName varchar(20), @ForthMemberName varchar(20)
	declare @FirstMemberNumber int, @SecondMemberNumber int, @ThirdMemberNumber int, @ForthMemberNumber int
	declare @GolfTime time
	declare @RequestedDay varchar(9), @RequestedStatus varchar(15)

	declare contact_cursor CURSOR FOR
	Select FirstMemberName, FirstMemberNumber, SecondMemberName, SecondMemberNumber, ThirdMemberName, ThirdMemberNumber, ForthMemberName, ForthMemberNumber, RequestedTeeTime,
	       RequestedDay, RequestStatus
	from StandingTeeTimeRequest
	where RequestedDay = Datename(Weekday, @date) and StartDate <= @date;

	

	OPEN contact_cursor

	FETCH NEXT FROM contact_cursor into @FirstMemberName, @FirstMemberNumber, @SecondMemberName, @SecondMemberNumber,
	                                @ThirdMemberName, @ThirdMemberNumber, @ForthMemberName, @ForthMemberNumber, @GolfTime,
									@RequestedDay, @RequestedStatus

	while @@FETCH_STATUS = 0
	begin
	update TeeTimes 
	set Member1Name = @FirstMemberName, Member1Number= @FirstMemberNumber, Member2Name = @SecondMemberName, Member2Number=@SecondMemberNumber, Member3Name=@ThirdMemberName, Member3Number=@ThirdMemberNumber,
	    Member4Name=@ForthMemberName, Member4Number=@ForthMemberNumber
	where @RequestedStatus = 'Approved' and
		  @RequestedDay = DATENAME(Weekday, @date) and
	      GolfTime = @GolfTime and
		  GolfDate = @date
	FETCH NEXT FROM contact_cursor into @FirstMemberName, @FirstMemberNumber, @SecondMemberName, @SecondMemberNumber,
	                                @ThirdMemberName, @ThirdMemberNumber, @ForthMemberName, @ForthMemberNumber, @GolfTime,
									@RequestedDay, @RequestedStatus

	end

	CLOSE contact_cursor;
	DEALLOCATE contact_cursor
	end
	return @ReturnCode

	execute GenerateTeeSheet

select * from TeeTimes


GRANT EXECUTE ON FetchDailySheet TO aspnetcore
select * from StandingTeeTimeRequest
--************ Procedure to fetch Daily TeeSheet *******************
create procedure FetchDailySheet(@GolfDate Date = null)
as
    declare @ReturnCode int
	set @ReturnCode = 1
	if @GolfDate is null
	   RAISERROR('FetchDailyTeeSheet - Required Parameter : @GolfDate',16,1)
	else
	   begin
	   select GolfDate, GolfDay, GolfTime, Member1Name, Member2Name, Member3Name, Member4Name, NoOfcarts, BookingDate1, BookingDate2, BookingDate3, BookingDate4
	   from TeeTimes 
	   where GolfDate=@GolfDate

	       if @@ERROR = 0
		        set @ReturnCode = 0
			else
			    RAISERROR('FetchDailyTeeSheet Error!',16,1)
	   end
	   return @ReturnCode


execute FetchDailySheet '24 February 2023'


GRANT EXECUTE ON FinalizeTeeTime TO aspnetcore
--******************* Book Tee Times StoredProcedure ****************
create procedure FinalizeTeeTime(@GolfDate Date =null,
								 @GolfTime varchar(7)=null,
								 @MemberName varchar(20) = null,
								 @MemberNumber int = null,
								 @NoOfCarts int = null
							)
as
     declare @ReturnCode int 
	 set @ReturnCode=1
	 if @GolfDate is null
	   RAISERROR('FinalizeTeeTime - Required Parameter : @GolfDate',16,1)
     if @GolfTime is null
	   RAISERROR('FinalizeTeeTime - Required Parameter : @GolfTime',16,1)
	 if @MemberName is null
	   RAISERROR('FinalizeTeeTime - Required Parameter : @MemberName',16,1)
	 if @MemberNumber is null
	   RAISERROR('FinalizeTeeTime - Required Parameter : @MemberNumber',16,1)
	 if @NoOfCarts is null
	   RAISERROR('FinalizeTeeTime - Required Parameter : @NoOfCarts',16,1)
	 if exists (select * from TeeTimes where ((@MemberNumber = Member1Number or @MemberNumber = Member2Number or @MemberNumber = Member3Number or @MemberNumber=Member4Number) and @GolfDate=GolfDate) )
	   RAISERROR('Already booked for the day',16,1)
	 else
	 BEGIN
     if exists (select * from TeeTimes where Member1Name is Null and GolfDate= @GolfDate and GolfTime= @GolfTime)
		 begin
		 update TeeTimes	
		 set Member1Name= @MemberName, Member1Number=@MemberNumber, NoOfcarts = (NoOfcarts + @NoOfCarts ) , BookingDate1=GETDATE()
		 where  GolfDate= @GolfDate and GolfTime= @GolfTime
	     end
	 else if exists (select * from TeeTimes where Member2Name is Null and GolfDate= @GolfDate and GolfTime= @GolfTime)
		 begin
		 update TeeTimes	
		 set Member2Name= @MemberName, Member2Number=@MemberNumber, NoOfcarts = (NoOfcarts + @NoOfCarts)  , BookingDate2=GETDATE()
		 where  GolfDate= @GolfDate and GolfTime= @GolfTime
	   	 end
	     

	 else if exists (select * from TeeTimes where Member3Name is Null and GolfDate= @GolfDate and GolfTime= @GolfTime)
		 begin
		 update TeeTimes	
		 set Member3Name= @MemberName, Member3Number=@MemberNumber, NoOfcarts = (NoOfcarts + @NoOfCarts ) , BookingDate3=GETDATE()
		 where  GolfDate= @GolfDate and GolfTime= @GolfTime
		 end

	 else 
	     if exists (select * from TeeTimes where Member4Name is Null and GolfDate= @GolfDate and GolfTime= @GolfTime)
		 begin
		 update TeeTimes	
		 set Member4Name= @MemberName, Member4Number=@MemberNumber, NoOfcarts = (NoOfcarts + @NoOfCarts ) , BookingDate4=GETDATE()
		 where  GolfDate= @GolfDate and GolfTime= @GolfTime
		 end
		

	       if @@ERROR = 0
		        set @ReturnCode = 0
			else
			    RAISERROR('FinalizeTeeTime Error!',16,1)
				
	 END

execute FinalizeTeeTime 'March 05 2023','7:22 am', 'Prabhjot Kaur', 11, 1



GRANT EXECUTE ON FindMember TO aspnetcore
--************** Find Member Stored Procedure for use by the clerk and Proshop Staff******************
create procedure FindMember(@MemberNumber int = null)
as
   declare @ReturnCode int
   set @ReturnCode = 1
   if @MemberNumber is null
      RAISERROR('FindMember: MemberNumber required',16,1)
   else
   begin
   select * from Member where MemberNumber = @MemberNumber

   	     if @@ERROR = 0
				set @ReturnCode = 0
			    else
				RAISERROR('FindMember Error!',16,1)

   end
   return @ReturnCode

execute FindMember 11


GRANT EXECUTE ON GetMemberDetailsUsingName TO aspnetcore
--****************************Find Member using MemberName*********************
create procedure GetMemberDetailsUsingName(@MemberName varchar(20) = null)
as
	declare @ReturnCode int
    set @ReturnCode = 1
	if @MemberName is null
		RAISERROR('GetMemberDetailsUsingName Error: MemberName required',16,1)
	else
	begin
	 select * from Member where MemberName = @MemberName

   	     if @@ERROR = 0
				set @ReturnCode = 0
			    else
				RAISERROR('FindMember Error!',16,1)

	end
	return @ReturnCode

execute GetMemberDetailsUsingName 'Prabhjot Kaur'


GRANT EXECUTE ON GetAvailableStandingTeeTimes TO aspnetcore
--**********************Stored Procedure to get the available tee times for standing tee time requests based on the day of the week****************
CREATE procedure GetAvailableStandingTeeTimes(@Day varchar(10) = null)
as
   begin
     select TeeTimes.GolfTime from TeeTimes
	 where TeeTimes.GolfTime not in
	 (select RequestedTeeTime from StandingTeeTimeRequest where StandingTeeTimeRequest.RequestedDay = @Day and StandingTeeTimeRequest.RequestStatus = 'Approved')
   end


execute GetAvailableStandingTeeTimes 'Sunday'



GRANT EXECUTE ON SubmitStandingTeeTimeRequest TO aspnetcore
--************ Store Procedure for submitting the Standing Tee Time Request*******************

create procedure SubmitStandingTeeTimeRequest(@FirstMemberName varchar(20) = null,
	                                          @SecondMemberName varchar(20) = null,
	                                          @ThirdMemberName varchar(20) = null,
	                                          @ForthMemberName varchar(20) = null,
	                                          @FirstMemberNumber int = null,
	                                          @SecondMemberNumber int = null,
	                                          @ThirdMemberNumber int = null,
	                                          @ForthMemberNumber int = null,
	                                          @RequestedDay varchar(9) = null,
	                                          @RequestedTeeTime time = null,
	                                          @StartDate date = null,
	                                          @EndDate date = null)
as
    declare @ReturnCode int
	set @ReturnCode = 1
	if @FirstMemberName is null
	    RAISERROR('SubmitStandingTeeTimeRequest: Required Parameter, @FirstMemberName',16,1)
    if @SecondMemberName is null
	    RAISERROR('SubmitStandingTeeTimeRequest: Required Parameter, @SecondMemberName',16,1)
    if @ThirdMemberName is null
	    RAISERROR('SubmitStandingTeeTimeRequest: Required Parameter, @ThirdMemberName',16,1)
	if @ForthMemberName is null
	    RAISERROR('SubmitStandingTeeTimeRequest: Required Parameter, @ForthMemberName',16,1)
	if @FirstMemberNumber is null
	    RAISERROR('SubmitStandingTeeTimeRequest: Required Parameter, @FirstMemberNumber',16,1)
    if @SecondMemberNumber is null
	    RAISERROR('SubmitStandingTeeTimeRequest: Required Parameter, @SecondMemberNumber',16,1)
    if @ThirdMemberNumber is null
	    RAISERROR('SubmitStandingTeeTimeRequest: Required Parameter, @ThirdMemberNumber',16,1)
	if @ForthMemberNumber is null
	    RAISERROR('SubmitStandingTeeTimeRequest: Required Parameter, @ForthMemberNumber',16,1)
	if @RequestedDay is null
	    RAISERROR('SubmitStandingTeeTimeRequest: Required Parameter, @RequestedDay',16,1)
    if @RequestedTeeTime is null
	    RAISERROR('SubmitStandingTeeTimeRequest: Required Parameter, @RequestedTeeTime',16,1)
    if @StartDate is null
	    RAISERROR('SubmitStandingTeeTimeRequest: Required Parameter, @StartDate',16,1)
	if @EndDate is null
	    RAISERROR('SubmitStandingTeeTimeRequest: Required Parameter, @EndDate',16,1)
	if exists (select * from StandingTeeTimeRequest where (@FirstMemberNumber = FirstMemberNumber or @FirstMemberNumber = SecondMemberNumber or @FirstMemberNumber = ThirdMemberNumber or @FirstMemberNumber=ForthMemberNumber))
	   RAISERROR('FirstMember already submitted a standing tee time request for this season',16,1)
	if exists (select * from StandingTeeTimeRequest where (@SecondMemberNumber = FirstMemberNumber or @SecondMemberNumber = SecondMemberNumber or @SecondMemberNumber = ThirdMemberNumber or @SecondMemberNumber=ForthMemberNumber))
	   RAISERROR('SecondMember already submitted a standing tee time request for this season',16,1)
	if exists (select * from StandingTeeTimeRequest where (@ThirdMemberNumber = FirstMemberNumber or @ThirdMemberNumber = SecondMemberNumber or @ThirdMemberNumber = ThirdMemberNumber or @ThirdMemberNumber=ForthMemberNumber))
	   RAISERROR('ThirdMember already submitted a standing tee time request for this season',16,1)
	if exists (select * from StandingTeeTimeRequest where (@ForthMemberNumber = FirstMemberNumber or @ForthMemberNumber = SecondMemberNumber or @ForthMemberNumber = ThirdMemberNumber or @ForthMemberNumber=ForthMemberNumber))
	   RAISERROR('ForthMember already submitted a standing tee time request for this season',16,1)
	else
	   begin
	   begin
		  if exists (Select * from Member where MemberName = @FirstMemberName and MemberNumber = @FirstMemberNumber) 
		  begin
		    if exists (Select * from Member where MemberName = @SecondMemberName and MemberNumber = @SecondMemberNumber) 
			begin
			  if exists (Select * from Member where MemberName = @ThirdMemberName and MemberNumber = @ThirdMemberNumber)
			     begin
				   if exists (Select * from Member where MemberName = @ForthMemberName and MemberNumber = @ForthMemberNumber)
                   BEGIN
								insert into StandingTeeTimeRequest
								(FirstMemberName,SecondMemberName,ThirdMemberName,ForthMemberName,FirstMemberNumber,SecondMemberNumber,ThirdMemberNumber,ForthMemberNumber,RequestedDay,RequestedTeeTime,StartDate,EndDate,RequestTime,RequestStatus)
								values
								(@FirstMemberName,@SecondMemberName,@ThirdMemberName,@ForthMemberName,@FirstMemberNumber,@SecondMemberNumber,@ThirdMemberNumber,@ForthMemberNumber,@RequestedDay,@RequestedTeeTime,@StartDate,@EndDate, GETDATE(), 'Approved' )


	                     END
						 Else
						       Raiserror('Please enter an existing forth member', 16,1)
						 End
						 Else
						       Raiserror('Please enter an existing third member', 16,1)
						 END
						 Else
						       Raiserror('Please enter an existing second member', 16,1)
						 END
						 Else
						       Raiserror('Please enter an existing shareholder member', 16,1)

								if @@ERROR = 0
								begin
										set @ReturnCode = 0
										

								end
										
									else
										RAISERROR('SubmitStandingTeeTimeRequest Error!',16,1)

	 end
	   return @ReturnCode

	   end

execute SubmitStandingTeeTimeRequest 'Prabhjot Kaur','deep kaur','Robert Duke','deep kaur',11,13,25,17,'Wednesday','7:15','April 15 2023','March 20 2023'


GRANT EXECUTE ON CancelStandingTeeTimeRequest TO aspnetcore
--***************Stored Procedure to Cancel Standing TeeTime Request***********************
create procedure CancelStandingTeeTimeRequest(@RequestNumber int = null)
as
   declare @ReturnCode int
	set @ReturnCode = 1
  if @RequestNumber is null
	 RAISERROR('RequestNumber Required!',16,1)
  if not exists(select * from StandingTeeTimeRequest where @RequestNumber = RequestNumber)
     RAISERROR('You do not have any existing standing Tee Time Requests',16,1)
  else
  begin
      update StandingTeeTimeRequest
	  set RequestStatus = 'Cancelled'
	  where @RequestNumber = RequestNumber

							 if @@ERROR = 0
								begin
										set @ReturnCode = 0
										
								end
							else
										RAISERROR('CancelStandingTeeTimeRequest Error!',16,1)
  end

  execute CancelStandingTeeTimeRequest 11

  
GRANT EXECUTE ON ShowStandingTeeTimeRequest TO aspnetcore
--****************Show the Standing Tee Time Requested by a player*******************
  create procedure ShowStandingTeeTimeRequest(@MemberNumber int = null)
  as
   declare @ReturnCode int
	set @ReturnCode = 1
   begin
    IF @MemberNumber IS NULL
    BEGIN
        RAISERROR('Please provide a valid member number.', 16, 1)
        RETURN
    END
	else
	begin
    SELECT RequestNumber, FirstMemberName, SecondMemberName, ThirdMemberName, ForthMemberName, RequestedDay, RequestedTeeTime
    FROM StandingTeeTimeRequest
    WHERE (
        (@MemberNumber IN (FirstMemberNumber, SecondMemberNumber, ThirdMemberNumber, ForthMemberNumber))
        AND RequestStatus = 'Approved')
		  
		                  if  @@ERROR = 0
								begin
										set @ReturnCode = 0
										
								end
							else
										RAISERROR('ShowStandingTeeTimeRequest Error!',16,1)
end
   end

execute ShowStandingTeeTimeRequest 15


select * from TeeTimes
drop procedure ShowBookedTeeTimes
GRANT EXECUTE ON ShowBookedTeeTimes TO aspnetcore
--**************** Stored Procedure to show all the booked tee times for a member ***************
CREATE PROCEDURE ShowBookedTeeTimes
    (@MemberNumber int = null)
AS
BEGIN
    IF @MemberNumber IS NULL
    BEGIN
        RAISERROR('Please provide a valid member number.', 16, 1)
        RETURN
    END

   SELECT 
        TeeTimes.GolfDate, 
        TeeTimes.GolfDay, 
        TeeTimes.GolfTime, 
        CASE 
            WHEN TeeTimes.Member1Number = @MemberNumber THEN TeeTimes.Member1CheckIn
            WHEN TeeTimes.Member2Number = @MemberNumber THEN TeeTimes.Member2CheckIn
            WHEN TeeTimes.Member3Number = @MemberNumber THEN TeeTimes.Member3CheckIn
            WHEN TeeTimes.Member4Number = @MemberNumber THEN TeeTimes.Member4CheckIn
        END AS CheckIn
    FROM TeeTimes
    WHERE TeeTimes.GolfDate >= CAST(GETDATE() AS date)
        AND @MemberNumber IN (TeeTimes.Member1Number, TeeTimes.Member2Number, TeeTimes.Member3Number, TeeTimes.Member4Number)

END

execute ShowBookedTeeTimes 11


GRANT EXECUTE ON CheckInMember TO aspnetcore
CREATE PROCEDURE CheckInMember
    (@MemberNumber int, @GolfDate date, @GolfTime time(7))
AS
BEGIN
    IF @MemberNumber IS NULL OR @GolfDate IS NULL OR @GolfTime IS NULL
    BEGIN
        RAISERROR('Please provide valid member number, golf date, and golf time.', 16, 1)
        RETURN
    END

    UPDATE TeeTimes
    SET
        Member1CheckIn = CASE WHEN Member1Number = @MemberNumber THEN 'Checked In' ELSE Member1CheckIn END,
        Member2CheckIn = CASE WHEN Member2Number = @MemberNumber THEN 'Checked In' ELSE Member2CheckIn END,
        Member3CheckIn = CASE WHEN Member3Number = @MemberNumber THEN 'Checked In' ELSE Member3CheckIn END,
        Member4CheckIn = CASE WHEN Member4Number = @MemberNumber THEN 'Checked In' ELSE Member4CheckIn END
    WHERE
        GolfDate = @GolfDate
        AND GolfTime = @GolfTime
        AND (@MemberNumber IN (Member1Number, Member2Number, Member3Number, Member4Number))

    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No matching tee time found for the provided member number, golf date, and golf time.', 16, 1)
        RETURN
    END
END




GRANT EXECUTE ON CancelTeeTime TO aspnetcore
--************* Store procedure for Proshop staff that removes a tee time booking (ability to cancel on the golf day as well)  ****************
create procedure CancelTeeTime(@MemberNumber int = null,
							   @GolfDate date = null,
							   @GolfTime time = null)
as
  if exists(select * from TeeTimes where @MemberNumber = Member1Number and @GolfDate = GolfDate and @GolfTime = GolfTime)
  begin
      update TeeTimes
	  set Member1Name =  null, Member1Number = null, BookingDate1 = null----, NoOfcarts = NoOfcarts-1
	  where @MemberNumber = Member1Number and @GolfDate = GolfDate and @GolfTime = GolfTime 
  end
  if exists(select * from TeeTimes where @MemberNumber = Member2Number and @GolfDate = GolfDate and @GolfTime = GolfTime)
  begin
      update TeeTimes
	  set Member2Name =  null, Member2Number = null, BookingDate2 = null--, NoOfcarts = NoOfcarts-1
	  where @MemberNumber = Member2Number and @GolfDate = GolfDate and @GolfTime = GolfTime 
  end
  if exists(select * from TeeTimes where @MemberNumber = Member3Number and @GolfDate = GolfDate and @GolfTime = GolfTime)
  begin
      update TeeTimes
	  set Member3Name =  null, Member3Number = null, BookingDate3 = null--, NoOfcarts = NoOfcarts-1
	  where @MemberNumber = Member3Number and @GolfDate = GolfDate and @GolfTime = GolfTime  
  end
  if exists(select * from TeeTimes where @MemberNumber = Member4Number and @GolfDate = GolfDate and @GolfTime = GolfTime)
  begin
      update TeeTimes
	  set Member4Name =  null, Member4Number = null, BookingDate4 = null--, NoOfcarts = NoOfcarts-1
	  where @MemberNumber = Member4Number and @GolfDate = GolfDate and @GolfTime = GolfTime 
  end
 
 execute CancelTeeTime 11, 'March 04 2023', '7:22am'



 
GRANT EXECUTE ON CancelTeeTimeClerkAndMembers TO aspnetcore
 --************* Store procedure for Clerk and players, that removes a tee time booking (Can not cancel on the day of golf)  ****************
create procedure CancelTeeTimeClerkAndMembers
(@MemberNumber int = null,
							   @GolfDate date = null,
							   @GolfTime time = null)
as
  if @GolfDate <= GETDATE()
  RAISERROR('Please ask Proshop staff to cancel TeeTime on the Golf Day',16,1)
  else
  begin
  if exists(select * from TeeTimes where @MemberNumber = Member1Number and @GolfDate = GolfDate and @GolfTime = GolfTime)
  begin
      update TeeTimes
	  set Member1Name =  null, Member1Number = null, BookingDate1 = null----, NoOfcarts = NoOfcarts-1
	  where @MemberNumber = Member1Number and @GolfDate = GolfDate and @GolfTime = GolfTime  and @GolfDate > GETDATE()
  end
  if exists(select * from TeeTimes where @MemberNumber = Member2Number and @GolfDate = GolfDate and @GolfTime = GolfTime)
  begin
      update TeeTimes
	  set Member2Name =  null, Member2Number = null, BookingDate2 = null--, NoOfcarts = NoOfcarts-1
	  where @MemberNumber = Member2Number and @GolfDate = GolfDate and @GolfTime = GolfTime and @GolfDate > GETDATE()
  end
  if exists(select * from TeeTimes where @MemberNumber = Member3Number and @GolfDate = GolfDate and @GolfTime = GolfTime)
  begin
      update TeeTimes
	  set Member3Name =  null, Member3Number = null, BookingDate3 = null--, NoOfcarts = NoOfcarts-1
	  where @MemberNumber = Member3Number and @GolfDate = GolfDate and @GolfTime = GolfTime and @GolfDate > GETDATE()
  end
  if exists(select * from TeeTimes where @MemberNumber = Member4Number and @GolfDate = GolfDate and @GolfTime = GolfTime)
  begin
      update TeeTimes
	  set Member4Name =  null, Member4Number = null, BookingDate4 = null--, NoOfcarts = NoOfcarts-1
	  where @MemberNumber = Member4Number and @GolfDate = GolfDate and @GolfTime = GolfTime and @GolfDate > GETDATE()
  end
  end

 execute CancelTeeTimeClerkAndMembers 11, 'March 04 2023','7:22am'

 execute FetchDailySheet 'March 04 2023'


 
GRANT EXECUTE ON SubmitMembershipApplication TO aspnetcore
 -----------***************  Submit Membership Applications  **********-----------------

 create procedure SubmitMembershipApplication(@LastName varchar(20) = null,
											@FirstName varchar(20) = null,
											@Address varchar(50) = null,
											@PostalCode varchar(6) = null,
											@Phone varchar(10) = null,
											@AlternatePhone varchar(10) = null,
											@Email varchar(50) = null,
											@DateOfBirth date = null,
											@Occupation varchar(50) = null,
											@CompanyName varchar(50) = null,
											@CompanyAddress varchar(50) = null,
											@CompanyPostalCode varchar(6) = null,
											@CompanyPhone varchar(10) = null,
											@ApplicationDate date = null,
											@Shareholder1Name varchar(20) = null,
											@Shareholder2Name varchar(20) = null,
											@RequestedRole varchar(20) = null)
as
    declare @ReturnCode int
	set @ReturnCode = 1
  if @LastName is null
		RAISERROR('LastName required!',16,1)
  if @FirstName is null
		RAISERROR('FirstName required!',16,1)
  if @Address is null
		RAISERROR('Address required!',16,1)
  if @PostalCode is null
		RAISERROR('PostalCode required!',16,1)
  if @Phone is null
		RAISERROR('Phone required!',16,1)
  if @Email is null
		RAISERROR('Email required!',16,1)
  if @DateOfBirth is null
		RAISERROR('DateOfBirth required!',16,1)
  if @Occupation is null
		RAISERROR('Occupation required!',16,1)
  if @CompanyName is null
		RAISERROR('CompanyName required!',16,1)
  if @CompanyAddress is null
		RAISERROR('CompanyAddress required!',16,1)
  if @CompanyPostalCode is null
		RAISERROR('CompanyPostalCode required!',16,1)
  if @CompanyPhone is null
		RAISERROR('CompanyPhone required!',16,1)
  if @ApplicationDate is null
		RAISERROR('ApplicationDate required!',16,1)
  if @Shareholder1Name is null
		RAISERROR('Shareholder1name required!',16,1)
  if @Shareholder2Name is null
		RAISERROR('Shareholder2Name required!',16,1)
  if @RequestedRole is null
		RAISERROR('RequestedRole required!',16,1)
  else
  begin
      insert into MembershipApplications
	  (LastName,FirstName,Address,PostalCode,Phone,AlternatePhone,Email,DateOfBirth,Occupation,CompanyName,CompanyAddress,CompanyPostalCode,CompanyPhone,ApplicationDate,OnlineSubmissionDate,Shareholder1Name,Shareholder2Name,ApplicationStatus, RequestedRole)
	  values
	  (@LastName,@FirstName,@Address,@PostalCode,@Phone,@AlternatePhone,@Email,@DateOfBirth,@Occupation,@CompanyName,@CompanyAddress,@CompanyPostalCode,@CompanyPhone,@ApplicationDate,GETDATE(),@Shareholder1Name,@Shareholder2Name,'On-Hold', @RequestedRole)
											

							if  @@ERROR = 0
								begin
										set @ReturnCode = 0
										
								end
							else
										RAISERROR('SubmitMembershipApplication Error!',16,1)


  end

execute SubmitMembershipApplication 'There','Hey','1regrth','T4T0S7','7809043245','54656644','jhewihtoifg','October 3 1994','SystemsAnalyst','Riva','hewihtj','ieihtk','56532223','March 04 2023','Prabhjot Kaur','Anmol Singh','Shareholder'
execute SubmitMembershipApplication 'Kaur','deep','1regrth','T4T0S7','7809043245','54656644','jhewihtoifg','October 3 1994','SystemsAnalyst','Riva','hewihtj','ieihtk','56532223','March 04 2023','Prabhjot Kaur','Anmol Singh','Associate'

select * from MembershipApplications
select * from Member

GRANT EXECUTE ON FetchAllMembershipApplications TO aspnetcore
---************ Review Membership Applications *********************
drop procedure FetchAllMembershipApplications
--************** This stored procedure allows the membership committee to find submitted membership applications
create procedure FetchAllMembershipApplications
as
   declare @ReturnCode int
   set @ReturnCode = 1
   begin
   select * from MembershipApplications where ApplicationStatus = 'On-Hold'

                            if  @@ERROR = 0
								begin
										set @ReturnCode = 0
										
								end
							else
										RAISERROR('FetchAllMembershipApplications Error!',16,1)
   end


   
GRANT EXECUTE ON ViewWaitlistedMembershipApplications TO aspnetcore
--******************************************************
create procedure ViewWaitlistedMembershipApplications
as
   declare @ReturnCode int
   set @ReturnCode = 1
   begin
   select * from MembershipApplications where ApplicationStatus = 'Waitlisted'

                            if  @@ERROR = 0
								begin
										set @ReturnCode = 0
										
								end
							else
										RAISERROR('ViewWaitlistedMembershipApplications Error!',16,1)
   end


   
GRANT EXECUTE ON ReviewMembershipApplication TO aspnetcore
drop procedure ReviewMembershipApplication
--************ Stored Procedure to Review Membership application - change the status of application, add new member to the table if application is approved, add charges to members account*******
create procedure ReviewMembershipApplication(@ApplicationNumber int = null,
											 @UpdatedStatus varchar(20) = null,
											 @Username varchar(10) output,
											 @MemberNumber int output)
as
   declare @ReturnCode int
   set @ReturnCode = 1
   declare @Balance int
   if @ApplicationNumber is null
		RAISERROR('ApplicationNumber is Required!',16,1)
   if @UpdatedStatus is null
		RAISERROR('UpdatedStatus is Required!',16,1)
   else
   begin
   if(@UpdatedStatus = 'Approved')
                Begin
                   --Firstly, change the status from on-hold to approved
                   update MembershipApplications
                   Set ApplicationStatus = @UpdatedStatus
                   where ApplicationNumber = @ApplicationNumber 
                    
				  -- Second step is to create member's account and provide him with a username 
				
				 insert into Member( MemberName,MembershipLevel, PhoneNumber, UserName, MemberRole)
                                 select  MembershipApplications.FirstName+' '+ MembershipApplications.LastName, 'Gold',
                                         MembershipApplications.Phone, 
                                         MembershipApplications.FirstName + cast(MembershipApplications.ApplicationNumber as varchar(3)), MembershipApplications.RequestedRole 
                                         from MembershipApplications
                                         where MembershipApplications.ApplicationNumber = @ApplicationNumber 
                 
				--  declare @MemberNumber int
				select @MemberNumber = (select Top 1 MemberNumber from Member order by MemberNumber desc)
				select @Username = (select UserName from Member where MemberNumber = @MemberNumber)

				declare @MemberName varchar(20)
				select @MemberName = MemberName from Member where Member.MemberNumber = @MemberNumber
				insert into MemberAccount
				(AccountNumber, MemberNumber, MemberName)
				values
				(@MemberNumber, @MemberNumber, @MemberName)

                 ---If requested role is shareholder, Add $10,000 shareholder fee and $3000 membership fee to the financial account
                if EXISTS (
					select * 
					from MembershipApplications 
					where ApplicationNumber = @ApplicationNumber AND RequestedRole = 'Shareholder'
				) 
						begin
						
						   insert into MemberAccountEntry
						   (AccountNumber,TransactionDescription, TransactionAmount, WhenCharged, WhenBooked)
						   values
						   (@MemberNumber,'Share Purchase Price',1000,DATEADD(day,30,Getdate()), DATEADD(day,30,Getdate()))

						   insert into MemberAccountEntry
						    (AccountNumber,TransactionDescription, TransactionAmount, WhenCharged, WhenBooked)
						   values
						   (@MemberNumber,'Shareholder Entrance Fee',2500,DATEADD(day,30,Getdate()), DATEADD(day,30,Getdate()))

						    insert into MemberAccountEntry
						    (AccountNumber,TransactionDescription, TransactionAmount, WhenCharged, WhenBooked)
						   values
						   (@MemberNumber,'Shareholder Entrance Fee second installment',2500,DATEADD(MONTH,6,Getdate()), DATEADD(MONTH,6,Getdate()))

						    insert into MemberAccountEntry
						    (AccountNumber,TransactionDescription, TransactionAmount, WhenCharged, WhenBooked)
						   values
						   (@MemberNumber,'Shareholder Entrance Fee third installment',2500,DATEADD(MONTH,12,Getdate()), DATEADD(MONTH,12,Getdate()))

						   insert into MemberAccountEntry
						    (AccountNumber,TransactionDescription, TransactionAmount, WhenCharged, WhenBooked)
						   values
						   (@MemberNumber,'Shareholder Entrance Fee Forth installment',2500,DATEADD(MONTH,18,Getdate()), DATEADD(MONTH,18,Getdate()))

						   select @Balance = SUM(TransactionAmount)
						   from
						   (
						   select TransactionAmount from MemberAccountEntry
						   where AccountNumber = @MemberNumber
						   )
						   as BalanceDue

						   update MemberAccount
						   set Balance = @Balance where AccountNumber = @MemberNumber
						end
						
                 End

    else if(@UpdatedStatus = 'Denied' or @UpdatedStatus = 'Waitlisted' )
                begin
                   update MembershipApplications
                   Set ApplicationStatus = @UpdatedStatus
                   where ApplicationNumber = @ApplicationNumber 
                end
                            if  @@ERROR = 0
								begin
										set @ReturnCode = 0
										
								end
							else
										RAISERROR('ReviewMembershipApplication Error!',16,1)


  end
  return @ReturnCode

declare @number int
declare @user varchar(20)
execute ReviewMembershipApplication 22, 'Approved', @user output, @number output
print @number
print @user

select * from Member
select * from GolfGame
select * from MemberAccount
select * from MemberAccountEntry

select * from MembershipApplications



GRANT EXECUTE ON ViewMemberAccount TO aspnetcore
drop procedure ViewMemberAccount
--*******************ViewMember Account************
create procedure ViewMemberAccount(@MemberNumber int = null)
as
  declare @ReturnCode int
	set @ReturnCode = 1
  if @MemberNumber is null
		RAISERROR('Member Number required to view account',16,1)
  else
  begin
  select MemberAccount.AccountNumber, MemberAccount.MemberName, MemberAccountEntry.TransactionDescription, MemberAccountEntry.TransactionAmount, MemberAccountEntry.WhenBooked, MemberAccountEntry.WhenCharged, MemberAccount.Balance
  from MemberAccount inner join MemberAccountEntry on MemberAccount.AccountNumber = MemberAccountEntry.AccountNumber
  where MemberNumber = @MemberNumber

							 if  @@ERROR = 0
								begin
										set @ReturnCode = 0
										
								end
							else
										RAISERROR('ViewMemberAccount Error!',16,1)

  end
 execute ViewMemberAccount 20


 
GRANT EXECUTE ON SubmitGolfGame TO aspnetcore
--******************* Submit Player Scores **********************--
create procedure SubmitGolfGame(@MemberNumber int = null,
                                @GolfCourse varchar(25) = null,
								@CourseRating decimal = null,
								@SlopeRating decimal = null,
								@GolfDate date = null,
								@GolfID int output)
as
   declare @ReturnCode int
	set @ReturnCode = 1
   if @MemberNumber is null
		RAISERROR('MemberNumber is Required!',16,1)
   if @GolfCourse is null
		RAISERROR('GolfCourse is Required!',16,1)
   if @CourseRating is null
		RAISERROR('CourseRating is Required!',16,1)
   if @SlopeRating is null
		RAISERROR('SlopeRating is Required!',16,1)
    if @GolfDate is null
		RAISERROR('GolfDate is Required!',16,1)
   else
   begin
      
      insert into GolfGame
	  (MemberNumber,GolfCourse,CourseRating,SlopeRating,GolfDate,ScoreSubmissionDate)
	  values
	  (@MemberNumber,@GolfCourse,@CourseRating,@SlopeRating,@GolfDate,GETDATE())

	  select @GolfID = @@IDENTITY
	      if @@ERROR = 0
		    set @ReturnCode = 0
		 else
		     RAISERROR('Insert Error: SubmitGolfTime',16,1)

   end

   declare @GolfNumber int 
   execute SubmitGolfGame '11','ClubBAIST','154.2','537.6','05 March 2023',@GolfNumber output
   print @GolfNumber

   select * from GolfGame


   
GRANT EXECUTE ON AddHoleScores TO aspnetcore
 --*************Add HolebyHole Score ******************
create procedure AddHoleScores(@GolfID int = null,
							   @HoleNumber int = null,
							   @HoleByHoleScore int = null,
							   @Par int = null)
as
	declare @ReturnCode int
	set @ReturnCode = 1
	if @GolfID is null
		RAISERROR('GolfID is required!', 16,1)
	if @HoleNumber is null
		RAISERROR('HoleNumber is Required!',16,1)
	if @HoleByHoleScore is null
		RAISERROR('HoleByHoleScore is Required!',16,1)
	if @Par is null
		RAISERROR('Par is Required!',16,1)
	else
	begin
	insert into HoleScores
	(GolfID, HoleNumber, HoleByHoleScore,HolePar)
	values
	(@GolfID,@HoleNumber,@HoleByHoleScore, @Par)

	     if @@ERROR = 0
		    set @ReturnCode = 0
		 else
		     RAISERROR('Insert Error: AddHoleScores',16,1)

	end
	return @ReturnCode


execute AddHoleScores 1, 1, 4, 3
execute AddHoleScores 1,2, 4,5


select * from HoleScores
select * from PlayerHandicap



GRANT EXECUTE ON UpdateTotalScores TO aspnetcore
drop procedure UpdateTotalScores
--*****************After HoleByHole Score has been entered for all the holes, calculate the total scores and add to the table*******************
create procedure UpdateTotalScores(@GolfID int = null,
									@TotalScores int = null,
									@MemberNumber int = null)
as
   declare @ReturnCode int
   set @ReturnCode = 1
	if @GolfID is null
		RAISERROR('GolfID is required!', 16,1)
	if @TotalScores is null
		RAISERROR('Total Scores Required!',16,1)
	else
	begin
	
	update GolfGame
	set TotalScore = @TotalScores, ScoreDifferential = (113/SlopeRating)*(@TotalScores-CourseRating-0)
	where GolfID = @GolfID

	declare @HandicapIndex decimal(5,2)
    select @HandicapIndex = AVG(ScoreDifferential)
	from
	(
	select top 8 ScoreDifferential
    FROM
    (
    select top 20 ScoreDifferential from GolfGame where MemberNumber = @MemberNumber
	order by GolfDate desc
	) as LatestScores
	) as HandicapIndex

	if not exists (select * from PlayerHandicap where PlayerNumber = @MemberNumber)
	begin
	insert into PlayerHandicap
	(PlayerNumber)
	values
	(@MemberNumber)
	end
	update PlayerHandicap
	set CalculationDate = GETDATE(), HandicapIndex =@HandicapIndex
	where PlayerNumber = @MemberNumber
	print @HandicapIndex

	 if @@ERROR = 0
		    set @ReturnCode = 0
		 else
		     RAISERROR('Insert Error: UpdateTotalScores',16,1)

	end
	return @ReturnCode

execute UpdateTotalScores 1, 8

select * from GolfGame

select * from PlayerHandicap


--**************Review MemberAccount *****************

--*************Get Last 20 total scores ******************


GRANT EXECUTE ON CalculatePlayerHandicapIndex TO aspnetcore
drop procedure CalculatePlayerHandicapIndex
create procedure CalculatePlayerHandicapIndex(@MemberNumber int = null)
as
  declare @ReturnCode int
   set @ReturnCode = 1
  
  if @MemberNumber is null
		RAISERROR('Member Number Required!',16,1)                                                                                                                                                                                                                                                                                                                                                                                                                                    
  else
  begin

    declare @HandicapIndex decimal
    select @HandicapIndex = AVG(ScoreDifferential)
	from
	(
	select top 8 ScoreDifferential
    FROM
    (
    select top 20 ScoreDifferential from GolfGame where MemberNumber = @MemberNumber
	order by GolfDate desc
	) as LatestScores
	) as HandicapIndex

	select @HandicapIndex as HandicapIndex

   if @@ERROR = 0
		    set @ReturnCode = 0
		 else
		     RAISERROR('GetLast20ScoresError',16,1)
					
  end
  return @ReturnCode


  
GRANT EXECUTE ON GetLast20Scores TO aspnetcore
 create procedure GetLast20Scores(@MemberNumber int = null)
 as
   declare @ReturnCode int
   set @ReturnCode = 1
   if @MemberNumber is null
		RAISERROR('Member Number Required!',16,1)
   else
   begin
   select top 20 ScoreDifferential from GolfGame where MemberNumber = @MemberNumber
	order by GolfDate desc

	if @@ERROR = 0
		    set @ReturnCode = 0
		 else
		     RAISERROR('GetLast20ScoresError',16,1)
					
  end
  return @ReturnCode
  
 execute GetLast20Scores 11


 
GRANT EXECUTE ON Last20ScoresAverage TO aspnetcore
 --**************Average of last 20 scores**************
drop procedure Last20ScoresAverage
create procedure Last20ScoresAverage(@MemberNumber int = null)
as
begin
   declare @ReturnCode int
   set @ReturnCode = 1

   if @MemberNumber is null
      RAISERROR('Member Number Required!',16,1)
   else
   begin
      select avg(ScoreDifferential) as Last20ScoresAverage
      from (
         select top 20 ScoreDifferential
         from GolfGame
         where MemberNumber = @MemberNumber
         order by ScoreDifferential asc, GolfDate desc
      ) as Last20Scores
   end

   if @@ERROR = 0
      set @ReturnCode = 0
   else
      RAISERROR('Last20Average',16,1)
end
 return @ReturnCode


 
GRANT EXECUTE ON ViewPlayerHandicap TO aspnetcore
create procedure ViewPlayerHandicap(@MemberNumber int = null)
as
   declare @ReturnCode int
   set @ReturnCode = 1
   if @MemberNumber is null
	   RAISERROR('ViewPlayerHandicap: MemberNumber is required',16,1)
	else
	begin
	select * from PlayerHandicap where PlayerNumber = @MemberNumber
					if @@ERROR = 0
					  set @ReturnCode = 0
				    else
					  RAISERROR('ViewPlayerHandicap Error',16,1)
	end
	return @ReturnCode

	execute ViewPlayerHandicap 11

--execute Last20ScoresAverage 11

  ---***************Calculate average of best 8 totalscores *************
  drop procedure Best8Average

  
GRANT EXECUTE ON Best8Average TO aspnetcore
create procedure Best8Average(@MemberNumber int = null)
as
begin
   declare @ReturnCode int
   set @ReturnCode = 1

   if @MemberNumber is null
      RAISERROR('Member Number Required!',16,1)
   else
   begin
      declare @AverageBest8 decimal(5,2)
     select @AverageBest8 =  avg(ScoreDifferential) 
      from (
         select top 8 ScoreDifferential
         from GolfGame
         where MemberNumber = @MemberNumber
         order by ScoreDifferential asc
      ) as Top8Scores
   end
   select @AverageBest8
   print @AverageBest8
   if @@ERROR = 0
      set @ReturnCode = 0
   else
      RAISERROR('Best8AverageError',16,1)
end

execute Best8Average 11
execute ViewPlayerHandicap 11


------********** Calculate Hnadicap Index ***************
------- HandicapIndex = (Average of 8 best scores - CourseRating)*113/SlopeRating

--drop procedure CalculateHandicapIndex
--create procedure CalculateHandicapIndex(@MemberNumber int = null)
--as
--  declare @ReturnCode int
--   set @ReturnCode = 1

--   if @MemberNumber is null
--      RAISERROR('Member Number Required!',16,1)
--   else
--   begin
--   declare @AverageBest8 decimal
--     select @AverageBest8 =  avg(TotalScore) 
--      from (
--         select top 8 TotalScore
--         from GolfGame
--         where MemberNumber = @MemberNumber
--         order by TotalScore asc, GolfDate desc
--      ) as Top8Scores

--	  print @AverageBest8
--	  declare @CourseRating decimal

--	  declare @SlopeRating decimal

--	  select @CourseRating = CourseRating, @SlopeRating = SlopeRating 
--	  from GolfGame where MemberNumber = @MemberNumber

--	  declare @HandicapIndex decimal
--	  set @HandicapIndex = (@AverageBest8 - @CourseRating)*(113/@SlopeRating)


--	  update PlayerHandicap
--	  set HandicapIndex = @HandicapIndex, CalculationDate = GETDATE()
--	  where PlayerNumber=@MemberNumber

--	  if @@ERROR = 0
--      set @ReturnCode = 0
--   else
--      RAISERROR('CalculateHandicapIndexError',16,1)


--   end


 execute CalculateHandicapIndex 11

 select * from MembershipApplications

 select * from TeeTimes