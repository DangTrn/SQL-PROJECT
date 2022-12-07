/*1. Bài tập luyện tập create table và populate dữ liệu
Bạn hãy tạo một bảng với tên là manager với những thông tin bên dưới*/
CREATE TABLE MANAGER
(ID int,
manager_name varchar(255), 
manager_level varchar(255),
region varchar(255),
salary int);

insert into MANAGER values
	(111,'Chris',2,'Nunavut',370),
	(112,'William',3,'West',240),
	(113,'Erin',3,'Prarie',377),
	(114,'Sam',4,'West',454),
	(115,'Pat',3,'West',168);

select * from MANAGER

--2. Thêm hai bản ghi cho bảng manager với thông tin như sau
insert into MANAGER values
	(116,'Parker',1,'Quebec',390),
	(117,'Robert',2,'Prarie',407);

--Xóa tất cả những thông tin trong bảng manager với manager_level = 2
delete MANAGER where manager_level=2

-- Cập nhập salary trong bảng manager là 500 với region là West và Quebec
update MANAGER
set salary = 500 
where region in ('West','Quebec')

/*Trong quá trình phân tích, bạn có thể thay đổi các câu hỏi giả thuyết nếu thấy dữ liệu không đáp ứng được câu hỏi.
Dưới đây là các câu hỏi gợi ý để bạn sáng tạo và mở rộng dần việc phân tích của mình.

Số lượng công ty startup trong danh sách?*/
use Unicorn

select top 5 * from Unicorn

select count(company), count(distinct company) from Unicorn

select company, count(*) company_count
from unicorn
group by company
having count(*) >1

select * from Unicorn where Company='Bolt'
--> có 936 công ty start up trong danh sách

--Tính theo quốc gia, có bao nhiêu công ty startup được đầu tư?
select country, count(company) company_count
from unicorn
group by Country

--Có bao nhiêu công ty nhận được đầu tư của 1, 2,3, 4 nhà đầu tư?
select top 5 * from unicorn

with temp as
(select column1, count(investor_name) as investors
from
	(select column1, investor_1, investor_2, investor_3, investor_4
	from unicorn) p
unpivot
	(investor_name for investor in (investor_1, investor_2, investor_3, investor_4)) as unpvt
group by column1)
select investors, count(column1) companies
from temp
group by investors
order by investors


--Tính theo lĩnh vực, có bao nhiêu công ty nhận được đầu tư?
select industry, count(company) companies
from unicorn
group by industry
order by count(company) desc

/*Tính theo thành phố, có bao nhiêu công ty nhận được đầu tư?
=> Quốc gia, thành phố, lĩnh vực nào có nhiều công ty khởi nghiệp nhất (màu mỡ và thu hút yếu tố khởi nghiệp nhất?)*/

select 
	country,
	city,
	[Artificial intelligence],
	[Auto & transportation],
	[Consumer & retail],
	[Cybersecurity],
	[Data management & analytics],
	[E-commerce & direct-to-consumer],
	[Edtech],
	[Fintech],
	[Hardware],
	[Health],
	[Internet software & services],
	[Mobile & telecommunications],
	[Other],
	[Supply chain logistics & delivery],
	[Travel]
from
	(select country, city, industry, company
	from unicorn) tbl
pivot
	(count(company) for industry IN ([Artificial intelligence],[Auto & transportation],[Consumer & retail],[Cybersecurity],[Data management & analytics],[E-commerce & direct-to-consumer],[Edtech],[Fintech],[Hardware],[Health],[Internet software & services],[Mobile & telecommunications],[Other],[Supply chain logistics & delivery],[Travel])) pvt

--6. Định giá nào lớn nhất là bao nhiêu? Công ty nào, gắn với nhà đầu tư nào, quốc gia nào, thành phố nào, lĩnh vực nào?

select top 1 company, valuation_b, country, city, industry, investor_1, investor_2, investor_3, investor_4
from unicorn
order by valuation_b desc


--7. Định giá nhỏ nhất là bao nhiêu? Công ty nào, gắn với nhà đầu tư nào, quốc gia nào, thành phố nào, lĩnh vực nào?
select top 1 company, valuation_b, country, city, industry, investor_1, investor_2, investor_3, investor_4
from unicorn
order by valuation_b asc

--=> Khái niệm “kỳ lân” trong dataset này đang được định nghĩa như thế nào? --> từ 1 tỷ đô trở lên

--Tại từng quốc gia, xem phân bổ số lượng startup nhận được đầu tư theo thời gian (năm). Năm nào là năm có nhiều startup nhận được đầu tư nhất (hay, làn sóng đầu tư VC nở rộ nhất vào năm nào?)*/
select top 10 * from unicorn

select country, [2007],[2008],[2009],[2010],[2011],[2012],[2013],[2014],[2015],[2016],[2017],[2018],[2019],[2020],[2021]
from
	(select country, year(Date_joined) YEAR, company
	from Unicorn) as pvt
pivot
	(count(company) for YEAR IN ([2007],[2008],[2009],[2010],[2011],[2012],[2013],[2014],[2015],[2016],[2017],[2018],[2019],[2020],[2021])) as p


--có tất cả bao nhiêu nhà đầu tư?
select count(distinct investor_name) investors
from
	(select company, investor_1, investor_2, investor_3, investor_4
	from unicorn) p
unpivot
	(investor_name for investor in (investor_1, investor_2, investor_3, investor_4)) as unpvt


--Nhà đầu tư nào đầu tư nhiều dự án nhất?
select  investor_name, count(column1) projects
from
	(select column1, investor_1, investor_2, investor_3, investor_4
	from unicorn) p
unpivot
	(investor_name for investor in (investor_1, investor_2, investor_3, investor_4)) as unpvt
group by investor_name
order by count(column1) desc

--nhà đầu tư nào đầu tư nhiều lĩnh vực nhất?
select  investor_name, count(distinct industry) industries
from
	(select industry, investor_1, investor_2, investor_3, investor_4
	from unicorn) p
unpivot
	(investor_name for investor in (investor_1, investor_2, investor_3, investor_4)) as unpvt
group by investor_name
order by count(distinct industry) desc

--nhà đầu tư nào đầu tư vào nhiều quốc gia nhất?
select  investor_name, count(distinct country) countries
from
	(select country, investor_1, investor_2, investor_3, investor_4
	from unicorn) p
unpivot
	(investor_name for investor in (investor_1, investor_2, investor_3, investor_4)) as unpvt
group by investor_name
order by count(distinct country) desc

--tổng hợp
select  investor_name, count(column1) projects, count(distinct country) countries, count(distinct industry) industries
from
	(select column1, industry, country, investor_1, investor_2, investor_3, investor_4
	from unicorn) p
unpivot
	(investor_name for investor in (investor_1, investor_2, investor_3, investor_4)) as unpvt
group by investor_name
order by count(column1) desc

select top 10 * from Unicorn

--có bao nhiêu nhà đầu tư thiên thần
select count(distinct Investor_1) investors
from Unicorn


--các nhà đầu tư này đầu tư bao nhiêu dự án với tư cách nhà đầu tư thiên thần
select investor_1, count(company) projects
from Unicorn
group by investor_1
order by count(company) desc

--Lĩnh vực nào thu hút nhiều nhà đầu tư thiên thần nhất
select industry, count(distinct investor_1) investors
from Unicorn
group by Industry
order by count(distinct investor_1) desc

--có bao nhiêu nhà đầu tư chỉ tham gia đầu tư từ vòng gọi vốn thứ hai trở đi
with investor_list as
(select investor_name, investor 
from
	(select column1, investor_1, investor_2, investor_3, investor_4
	from unicorn) p
unpivot
	(investor_name for investor in (investor_1, investor_2, investor_3, investor_4)) as unpvt)
select count(distinct a.investor_name) investors
from
	(select investor_name, investor
	from investor_list
	where investor<>'Investor_1') a
left join
	(select investor_name, investor
	from investor_list
	where investor='Investor_1') b
	on a.investor_name=b.investor_name
where b.investor is null

--các nhà đầu tư chỉ tham gia từ vòng hai đó đầu tư bao nhiêu dự án, ở bao nhiêu lĩnh vực và tại bao nhiêu quốc gia
with investor_list as
	(select investor_name, column1, Country, Industry, investor 
	from
		(select column1, Country, Industry, investor_1, investor_2, investor_3, investor_4
		from unicorn) p
	unpivot
		(investor_name for investor in (investor_1, investor_2, investor_3, investor_4)) as unpvt)
select a.investor_name, count(a.column1) projects, count(distinct a.Country) countries, count(distinct a.industry) industries
from
	(select investor_name, column1, Country, Industry, investor
	from investor_list
	where investor<>'Investor_1') a
left join
	(select investor_name, investor
	from investor_list
	where investor='Investor_1') b
	on a.investor_name=b.investor_name
where b.investor is null
group by a.investor_name
order by count(a.column1) desc
