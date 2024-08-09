create table coffee (
	SubmissionID varchar,
	Age varchar,
	cupsperday varchar,
	place varchar,
	athome varchar,
	atoffice varchar,
	onthego varchar,
	atcafe varchar,
	brewingstyle varchar,
	pourover varchar,
	frenchpress varchar,
	Espresso varchar,
	coffeemachine	 varchar,
	Podcapsulemachine varchar,
	Instantcoffee	varchar,
	beantocup	varchar,
	coldbrew	varchar,
	coffeeextract	varchar,
	brewother	varchar,
	Onthegobuy varchar,
	Nationalchain varchar,
	Localcafe	varchar,
	Drivethru varchar,
	Specialtycoffeeshop varchar,
	Deliorsupermarket varchar,
	Other varchar,
	favoritecoffeedrink varchar,	
	addtocoffee	varchar,
	justblack	varchar,
	Milkdairylternative varchar,
	Sugarorsweetener varchar,
	Flavorsyrup	varchar,
	addOther	varchar,
	dairyadd varchar,
	Wholemilk varchar,
	Skimmilk varchar,
	Halfandhalf varchar,
	Coffeecreamer varchar,
	Flavoredcoffeecreamer varchar,
	Oatmilk	varchar,
	Almondmilk	varchar,
	Soymilk varchar,
	dairtyaddOther varchar,
	addsugarorsweetener varchar,
	GranulatedSugar	varchar,
	ArtificialSweeteners  varchar,
	Honey	varchar,
	MapleSyrup varchar,
	Stevia	 varchar,
	AgaveNectar varchar,
	BrownSugar	varchar,
	RawSugar varchar,
	flavorings varchar,
	VanillaSyrup varchar,
	CaramelSyrup varchar,
	HazelnutSyrup varchar,
	Cinnamon varchar,
	PeppermintSyrup varchar,
	flavoringsOther varchar,
	Beforetasting varchar,
	coffeestrength	varchar,
	roastlevel	varchar,
	caffeineamt	varchar,
	CoffeeABitterness int,
	CoffeeAAcidity	int,
	CoffeeAPersonalPreference int,
	CoffeeBBitterness int,
	CoffeeBAcidity	int,
	CoffeeBPersonalPreference int,
	CoffeeCBitterness int,
	CoffeeCAcidity	int,
	CoffeeCPersonalPreference int,
	CoffeeDBitterness int,
	CoffeeDAcidity	int,
	CoffeeDPersonalPreference int,
	aorborc	varchar,
	AorD varchar,
	favoritecoffee varchar,	
	monthlyexp varchar,
	whycoffee	varchar,
	Ittastesgood varchar,
	caffeine	varchar,
	ritual	varchar,
	bathroom	varchar,
	whycoffeeOther varchar,
	maxpaid	varchar,
	maxwilling	varchar,
	valued	varchar,
	equipspent varchar
)

select *
from coffee

---- no of cafe-goers ---- out of home coffee drinkers

with t1 as (select distinct(count(submissionid)) as total_count
			from coffee),
t2 as (select distinct(count(submissionid)) as cafe_goers
	   from coffee
	   where atcafe='TRUE'),
t3 as (select distinct(count(submissionid)) as out_of_home
	   from coffee
	   where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE')	   
select 'cafe-goers' as target_audience,
        total_count as total_count,
		cafe_goers as count,
		round((t2.cafe_goers*100/t1.total_count), 2) as percentage
from t1, t2
union all
select 'out-of-home-coffee-drinkers' as target_audience,
        total_count as total_count,
		out_of_home as count,
		round((t3.out_of_home*100/t1.total_count), 2) as percentage
from t1, t3

----- brewingstyle (cafe_goers)

with t1 as (select distinct(count(submissionid)) as total_count
			from coffee
			where atcafe='TRUE'),
t2 as (select
	   sum(case when pourover='TRUE' then 1 else 0 end) as count,
	   sum(case when frenchpress='TRUE' then 1 else 0 end) as frenchpress_count,
	   sum(case when espresso='TRUE' then 1 else 0 end) as espresso_count,
	   sum(case when coffeemachine='TRUE' then 1 else 0 end) as coffeemachine_count,
	   sum(case when podcapsulemachine='TRUE' then 1 else 0 end) as podcapsulemachine_count,
	   sum(case when instantcoffee='TRUE' then 1 else 0 end) as instantcoffee_count,
	   sum(case when beantocup='TRUE' then 1 else 0 end) as beantocup_count,
	   sum(case when coldbrew='TRUE' then 1 else 0 end) as coldbrew_count,
	   sum(case when coffeeextract='TRUE' then 1 else 0 end) as coffeeextract_count,
	   sum(case when brewother='TRUE' then 1 else 0 end) as brewother_count
	  from coffee
	  where atcafe='TRUE')
select 'pourover' as brewingstyle, count, (t2.count*100/t1.total_count) as percentage
from t1, t2
union all
select 'frenchpress' as brewingstyle, frenchpress_count, (t2.frenchpress_count*100/t1.total_count) as percentage
from t1, t2
union all
select 'espresso' as brewingstyle, espresso_count, (t2.espresso_count*100/t1.total_count) as percentage
from t1, t2
union all
select 'coffeemachine' as brewingstyle, coffeemachine_count, (t2.coffeemachine_count*100/t1.total_count) as percentage
from t1, t2
union all
select 'podcapsulemachine' as brewingstyle, podcapsulemachine_count, (t2.podcapsulemachine_count*100/t1.total_count) as percentage
from t1, t2
union all
select 'instantcoffee' as brewingstyle, instantcoffee_count, (t2.instantcoffee_count*100/t1.total_count) as percentage
from t1, t2
union all
select 'beantocup' as brewingstyle, beantocup_count, (t2.beantocup_count*100/t1.total_count) as percentage
from t1, t2
union all
select 'coldbrew' as brewingstyle, coldbrew_count, (t2.coldbrew_count*100/t1.total_count)  as percentage
from t1, t2
union all
select 'coffeeextract' as brewingstyle, coffeeextract_count, (t2.coffeeextract_count*100/t1.total_count) as percentage
from t1, t2
union all
select 'brewother' as brewingstyle, brewother_count, (t2.brewother_count*100/t1.total_count) as percentage
from t1, t2
order by count desc

----- brewingstyle (out of home drinkers)

with t1 as (select distinct(count(submissionid)) as total_count
			from coffee
			where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select
	   sum(case when pourover='TRUE' then 1 else 0 end) as count,
	   sum(case when frenchpress='TRUE' then 1 else 0 end) as frenchpress_count,
	   sum(case when espresso='TRUE' then 1 else 0 end) as espresso_count,
	   sum(case when coffeemachine='TRUE' then 1 else 0 end) as coffeemachine_count,
	   sum(case when podcapsulemachine='TRUE' then 1 else 0 end) as podcapsulemachine_count,
	   sum(case when instantcoffee='TRUE' then 1 else 0 end) as instantcoffee_count,
	   sum(case when beantocup='TRUE' then 1 else 0 end) as beantocup_count,
	   sum(case when coldbrew='TRUE' then 1 else 0 end) as coldbrew_count,
	   sum(case when coffeeextract='TRUE' then 1 else 0 end) as coffeeextract_count,
	   sum(case when brewother='TRUE' then 1 else 0 end) as brewother_count
	  from coffee
	  where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE')
select 'pourover' as brewingstyle, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'frenchpress' as brewingstyle, frenchpress_count, round((t2.frenchpress_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'espresso' as brewingstyle, espresso_count, round((t2.espresso_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'coffeemachine' as brewingstyle, coffeemachine_count, round((t2.coffeemachine_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'podcapsulemachine' as brewingstyle, podcapsulemachine_count, round((t2.podcapsulemachine_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'instantcoffee' as brewingstyle, instantcoffee_count, round((t2.instantcoffee_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'beantocup' as brewingstyle, beantocup_count, round((t2.beantocup_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'coldbrew' as brewingstyle, coldbrew_count, round((t2.coldbrew_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'coffeeextract' as brewingstyle, coffeeextract_count, round((t2.coffeeextract_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'brewother' as brewingstyle, brewother_count, round((t2.brewother_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
order by count desc

--------on the go buy (cafe-goers)

with t1 as (select distinct(count(submissionid)) as total_count
			from coffee
			where atcafe='TRUE'),
t2 as (select
	   sum(case when nationalchain='TRUE' then 1 else 0 end) as count,
	   sum(case when localcafe='TRUE' then 1 else 0 end) as localcafe_count,
	   sum(case when drivethru='TRUE' then 1 else 0 end) as drivethru_count,
	   sum(case when specialtycoffeeshop='TRUE' then 1 else 0 end) as specialtycoffeeshop_count,
	   sum(case when deliorsupermarket='TRUE' then 1 else 0 end) as deliorsupermarket_count,
	   sum(case when other='TRUE' then 1 else 0 end) other_count
	  from coffee
	  where atcafe='TRUE')
select 'nationalchain' as onthegobuy, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'localcafe' as onthegobuy, localcafe_count, round((t2.localcafe_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'drivethru' as onthegobuy, drivethru_count, round((t2.drivethru_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'specialtycoffeeshop' as onthegobuy, specialtycoffeeshop_count, round((t2.specialtycoffeeshop_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'deliorsupermarket' as onthegobuy, deliorsupermarket_count, round((t2.deliorsupermarket_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'other' as onthegobuy, other_count, round((t2.other_count*100/t1.total_count),2) || '%' as percentage
from t1, t2

----- on the go buy out of home drinkers

with t1 as (select distinct(count(submissionid)) as total_count
			from coffee
			where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select
	   sum(case when nationalchain='TRUE' then 1 else 0 end) as nationalchain_count,
	   sum(case when localcafe='TRUE' then 1 else 0 end) as localcafe_count,
	   sum(case when drivethru='TRUE' then 1 else 0 end) as drivethru_count,
	   sum(case when specialtycoffeeshop='TRUE' then 1 else 0 end) as specialtycoffeeshop_count,
	   sum(case when deliorsupermarket='TRUE' then 1 else 0 end) as deliorsupermarket_count,
	   sum(case when other='TRUE' then 1 else 0 end) other_count
	  from coffee
	  where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE')
select onthegobuy, count, percentage
from (select 'nationalchain' as onthegobuy, nationalchain_count as count, round((t2.nationalchain_count::decimal*100/t1.total_count),2) as percentage
      from t1, t2
      union all
      select 'localcafe' as onthegobuy, localcafe_count as count, round((t2.localcafe_count::decimal*100/t1.total_count),2) as percentage
      from t1, t2
union all
select 'drivethru' as onthegobuy, drivethru_count as count, round((t2.drivethru_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'specialtycoffeeshop' as onthegobuy, specialtycoffeeshop_count as count, round((t2.specialtycoffeeshop_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'deliorsupermarket' as onthegobuy, deliorsupermarket_count as count, round((t2.deliorsupermarket_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'other' as onthegobuy, other_count as count, round((t2.other_count::decimal*100/t1.total_count),2) as percentage
from t1, t2) x
order by percentage desc

------- favoritecoffedrink cafe goers

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE'),
t2 as (select favoritecoffeedrink, count(favoritecoffeedrink) as count
from coffee
where atcafe='TRUE' and favoritecoffeedrink is not null
group by coffee.favoritecoffeedrink
order by count desc)
select favoritecoffeedrink, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2

------- favoritecoffedrink out of home

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select favoritecoffeedrink, count(favoritecoffeedrink) as count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE' and favoritecoffeedrink is not null
group by coffee.favoritecoffeedrink
order by count desc)
select favoritecoffeedrink, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2

------- add to coffee cafe goers

with t1 as (select distinct(count(submissionid)) as total_count
			from coffee
			where atcafe='TRUE'),
t2 as (select
	   sum(case when justblack='TRUE' then 1 else 0 end) as count,
	   sum(case when milkdairylternative='TRUE' then 1 else 0 end) as milkdairylternative_count,
	   sum(case when sugarorsweetener='TRUE' then 1 else 0 end) as sugarorsweetener_count,
	   sum(case when flavorsyrup='TRUE' then 1 else 0 end) as flavorsyrup_count,
	   sum(case when addother='TRUE' then 1 else 0 end) addother_count
	  from coffee
	  where atcafe='TRUE')
select 'justblack' as addtocoffee, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'milkdairylternative' as addtocoffee, milkdairylternative_count, round((t2.milkdairylternative_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'sugarorsweetener' as addtocoffee, sugarorsweetener_count, round((t2.sugarorsweetener_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'flavorsyrup' as addtocoffee, flavorsyrup_count, round((t2.flavorsyrup_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'addother' as addtocoffee, addother_count, round((t2.addother_count*100/t1.total_count),2) || '%' as percentage
from t1, t2

------- add to coffee out of home

with t1 as (select distinct(count(submissionid)) as total_count
			from coffee
			where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select
	   sum(case when justblack='TRUE' then 1 else 0 end) as count,
	   sum(case when milkdairylternative='TRUE' then 1 else 0 end) as milkdairylternative_count,
	   sum(case when sugarorsweetener='TRUE' then 1 else 0 end) as sugarorsweetener_count,
	   sum(case when flavorsyrup='TRUE' then 1 else 0 end) as flavorsyrup_count,
	   sum(case when addother='TRUE' then 1 else 0 end) addother_count
	  from coffee
	  where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE')
select 'justblack' as addtocoffee, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'milkdairylternative' as addtocoffee, milkdairylternative_count, round((t2.milkdairylternative_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'sugarorsweetener' as addtocoffee, sugarorsweetener_count, round((t2.sugarorsweetener_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'flavorsyrup' as addtocoffee, flavorsyrup_count, round((t2.flavorsyrup_count*100/t1.total_count),2) || '%' as percentage
from t1, t2
union all
select 'addother' as addtocoffee, addother_count, round((t2.addother_count*100/t1.total_count),2) || '%' as percentage
from t1, t2

------- dairy add cafe goers

with t1 as (select distinct(count(submissionid)) as total_count
			from coffee
			where atcafe='TRUE'),
t2 as (select
	   sum(case when wholemilk='TRUE' then 1 else 0 end) as count,
	   sum(case when skimmilk='TRUE' then 1 else 0 end) as skimmilk_count,
	   sum(case when halfandhalf='TRUE' then 1 else 0 end) as halfandhalf_count,
	   sum(case when coffeecreamer='TRUE' then 1 else 0 end) as coffeecreamer_count,
	   sum(case when flavoredcoffeecreamer='TRUE' then 1 else 0 end) flavoredcoffeecreamer_count,
	   sum(case when oatmilk='TRUE' then 1 else 0 end) as oatmilk_count,
	   sum(case when almondmilk='TRUE' then 1 else 0 end) as almondmilk_count,
	   sum(case when soymilk='TRUE' then 1 else 0 end) as soymilk_count
	  from coffee
	  where atcafe='TRUE')
select 'wholemilk' as dairyadd, count, round((t2.count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'skimmilk' as dairyadd, skimmilk_count, round((t2.skimmilk_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'halfandhalf' as dairyadd, halfandhalf_count, round((t2.halfandhalf_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'coffeecreamer' as dairyadd, coffeecreamer_count, round((t2.coffeecreamer_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'flavoredcoffeecreamer' as dairyadd, flavoredcoffeecreamer_count, round((t2.flavoredcoffeecreamer_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'oatmilk' as dairyadd, oatmilk_count, round((t2.oatmilk_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'almondmilk' as dairyadd, almondmilk_count, round((t2.almondmilk_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'soymilk' as dairyadd, soymilk_count, round((t2.soymilk_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
order by percentage desc

------- dairy add out of home drinkers

with t1 as (select distinct(count(submissionid)) as total_count
			from coffee
			where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select
	   sum(case when wholemilk='TRUE' then 1 else 0 end) as count,
	   sum(case when skimmilk='TRUE' then 1 else 0 end) as skimmilk_count,
	   sum(case when halfandhalf='TRUE' then 1 else 0 end) as halfandhalf_count,
	   sum(case when coffeecreamer='TRUE' then 1 else 0 end) as coffeecreamer_count,
	   sum(case when flavoredcoffeecreamer='TRUE' then 1 else 0 end) flavoredcoffeecreamer_count,
	   sum(case when oatmilk='TRUE' then 1 else 0 end) as oatmilk_count,
	   sum(case when almondmilk='TRUE' then 1 else 0 end) as almondmilk_count,
	   sum(case when soymilk='TRUE' then 1 else 0 end) as soymilk_count
	  from coffee
	  where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE')
select 'wholemilk' as dairyadd, count, round((t2.count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'skimmilk' as dairyadd, skimmilk_count, round((t2.skimmilk_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'halfandhalf' as dairyadd, halfandhalf_count, round((t2.halfandhalf_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'coffeecreamer' as dairyadd, coffeecreamer_count, round((t2.coffeecreamer_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'flavoredcoffeecreamer' as dairyadd, flavoredcoffeecreamer_count, round((t2.flavoredcoffeecreamer_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'oatmilk' as dairyadd, oatmilk_count, round((t2.oatmilk_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'almondmilk' as dairyadd, almondmilk_count, round((t2.almondmilk_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'soymilk' as dairyadd, soymilk_count, round((t2.soymilk_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
order by percentage desc

------add sugar or sweetener (cafe goers)

with t1 as (select distinct(count(submissionid)) as total_count
			from coffee
			where atcafe='TRUE'),
t2 as (select
	   sum(case when granulatedsugar='TRUE' then 1 else 0 end) as count,
	   sum(case when artificialsweeteners='TRUE' then 1 else 0 end) as artificialsweeteners_count,
	   sum(case when honey='TRUE' then 1 else 0 end) as honey_count,
	   sum(case when maplesyrup='TRUE' then 1 else 0 end) as maplesyrup_count,
	   sum(case when stevia='TRUE' then 1 else 0 end) stevia_count,
	   sum(case when agavenectar='TRUE' then 1 else 0 end) as agavenectar_count,
	   sum(case when brownsugar='TRUE' then 1 else 0 end) as brownsugar_count,
	   sum(case when rawsugar='TRUE' then 1 else 0 end) as rawsugar_count
	  from coffee
	  where atcafe='TRUE')
select 'granulatedsugar' as sugarorsweetener, count, round((t2.count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'artificialsweeteners' as sugarorsweetener, artificialsweeteners_count, round((t2.artificialsweeteners_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'honey' as sugarorsweetener, honey_count, round((t2.honey_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'maplesyrup' as sugarorsweetener, maplesyrup_count, round((t2.maplesyrup_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'stevia' as sugarorsweetener, stevia_count, round((t2.stevia_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'agavenectar' as sugarorsweetener, agavenectar_count, round((t2.agavenectar_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'brownsugar' as sugarorsweetener, brownsugar_count, round((t2.brownsugar_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'rawsugar' as sugarorsweetener, rawsugar_count, round((t2.rawsugar_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
order by percentage desc

------ sugar or sweetener out of home

with t1 as (select distinct(count(submissionid)) as total_count
			from coffee
			where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select
	   sum(case when granulatedsugar='TRUE' then 1 else 0 end) as count,
	   sum(case when artificialsweeteners='TRUE' then 1 else 0 end) as artificialsweeteners_count,
	   sum(case when honey='TRUE' then 1 else 0 end) as honey_count,
	   sum(case when maplesyrup='TRUE' then 1 else 0 end) as maplesyrup_count,
	   sum(case when stevia='TRUE' then 1 else 0 end) stevia_count,
	   sum(case when agavenectar='TRUE' then 1 else 0 end) as agavenectar_count,
	   sum(case when brownsugar='TRUE' then 1 else 0 end) as brownsugar_count,
	   sum(case when rawsugar='TRUE' then 1 else 0 end) as rawsugar_count
	  from coffee
	  where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE')
select 'granulatedsugar' as sugarorsweetener, count, round((t2.count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'artificialsweeteners' as sugarorsweetener, artificialsweeteners_count, round((t2.artificialsweeteners_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'honey' as sugarorsweetener, honey_count, round((t2.honey_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'maplesyrup' as sugarorsweetener, maplesyrup_count, round((t2.maplesyrup_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'stevia' as sugarorsweetener, stevia_count, round((t2.stevia_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'agavenectar' as sugarorsweetener, agavenectar_count, round((t2.agavenectar_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'brownsugar' as sugarorsweetener, brownsugar_count, round((t2.brownsugar_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'rawsugar' as sugarorsweetener, rawsugar_count, round((t2.rawsugar_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
order by percentage desc

----- beforetasting cafe goers

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE'),
t2 as (select beforetasting, count(beforetasting) as count
from coffee
where atcafe='TRUE' and beforetasting is not null
group by coffee.beforetasting
order by count desc)
select beforetasting, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2

----- beforetasting pref out of home

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select beforetasting, count(beforetasting) as count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE' 
group by coffee.beforetasting
order by count desc)
select beforetasting, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
where beforetasting is not null

--------- coffeestrength cafe goers

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE'),
t2 as (select coffeestrength, count(coffeestrength) as count
from coffee
where atcafe='TRUE' and coffeestrength is not null
group by coffee.coffeestrength
order by count desc)
select coffeestrength, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2

--------- coffeestrength out of home

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select coffeestrength, count(coffeestrength) as count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE' 
group by coffee.coffeestrength
order by count desc)
select coffeestrength, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
where coffeestrength is not null

--------- roastlevel cafe goers

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE'),
t2 as (select roastlevel, count(roastlevel) as count
from coffee
where atcafe='TRUE' and roastlevel is not null
group by coffee.roastlevel
order by count desc)
select roastlevel, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2

--------- roastlevel out of home 

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select roastlevel, count(roastlevel) as count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE' 
group by coffee.roastlevel
order by count desc)
select roastlevel, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
where roastlevel is not null

--------- caffeineamt cafe goers

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE'),
t2 as (select caffeineamt, count(caffeineamt) as count
from coffee
where atcafe='TRUE' and caffeineamt is not null
group by coffee.caffeineamt
order by count desc)
select caffeineamt, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2

--------- caffeineamt out of home 

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select caffeineamt, count(caffeineamt) as count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE' 
group by coffee.caffeineamt
order by count desc)
select caffeineamt, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
where caffeineamt is not null

------- (a or b or c) cafe goers

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE'),
t2 as (select aorborc, count(aorborc) as count
from coffee
where atcafe='TRUE' and aorborc is not null
group by coffee.aorborc
order by count desc)
select aorborc, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2

------- (a or b or c) out of home

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select aorborc, count(aorborc) as count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE' 
group by coffee.aorborc
order by count desc)
select aorborc, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
where aorborc is not null

-----a or d (cafe goers)

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE'),
t2 as (select aord, count(aord) as count
from coffee
where atcafe='TRUE' and aord is not null
group by coffee.aord
order by count desc)
select aord, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2

-----a or d (out of home)

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select aord, count(aord) as count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE' 
group by coffee.aord
order by count desc)
select aord, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
where aord is not null

---- favoritecoffee cafe goers

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE'),
t2 as (select favoritecoffee, count(favoritecoffee) as count
from coffee
where atcafe='TRUE' and favoritecoffee is not null
group by coffee.favoritecoffee
order by count desc)
select favoritecoffee, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2


----- favoritecoffee out of home

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select favoritecoffee, count(favoritecoffee) as count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'
group by coffee.favoritecoffee
order by count desc)
select favoritecoffee, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
where favoritecoffee is not null

----- monthlyexp cafe goers

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE'),
t2 as (select monthlyexp, count(monthlyexp) as count
from coffee
where atcafe='TRUE' and monthlyexp is not null
group by coffee.monthlyexp
order by monthlyexp)
select monthlyexp, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
order by case when monthlyexp = '<$20' then 1
              when monthlyexp = '$20-$40' then 2
              when monthlyexp = '$40-$60' then 3
			  when monthlyexp = '$60-$80' then 4
			  when monthlyexp = '$80-$100' then 5
			  else 6 end
			  
----- monthlyexp out of home

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select monthlyexp, count(monthlyexp) as count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'
group by coffee.monthlyexp)
select monthlyexp, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
where monthlyexp is not null
order by case when monthlyexp = '<$20' then 1
              when monthlyexp = '$20-$40' then 2
              when monthlyexp = '$40-$60' then 3
			  when monthlyexp = '$60-$80' then 4
			  when monthlyexp = '$80-$100' then 5
			  else 6 end

------ whycoffee cafe goers

with t1 as (select distinct(count(submissionid)) as total_count
			from coffee
			where atcafe='TRUE'),
t2 as (select
	   sum(case when ittastesgood='TRUE' then 1 else 0 end) as count,
	   sum(case when caffeine='TRUE' then 1 else 0 end) as caffeine_count,
	   sum(case when ritual='TRUE' then 1 else 0 end) as ritual_count,
	   sum(case when bathroom='TRUE' then 1 else 0 end) as bathroom_count,
	   sum(case when whycoffeeother='TRUE' then 1 else 0 end) whycoffeeother_count
	  from coffee
	  where atcafe='TRUE')
select 'ittastesgood' as whycoffee, count, round((t2.count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'caffeine' as whycoffee, caffeine_count, round((t2.caffeine_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'ritual' as whycoffee, ritual_count, round((t2.ritual_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'bathroom' as whycoffee, bathroom_count, round((t2.bathroom_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'whycoffeeother' as whycoffee, whycoffeeother_count, round((t2.whycoffeeother_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
order by percentage desc

----- whycoffee out of home

with t1 as (select distinct(count(submissionid)) as total_count
			from coffee
			where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select
	   sum(case when ittastesgood='TRUE' then 1 else 0 end) as count,
	   sum(case when caffeine='TRUE' then 1 else 0 end) as caffeine_count,
	   sum(case when ritual='TRUE' then 1 else 0 end) as ritual_count,
	   sum(case when bathroom='TRUE' then 1 else 0 end) as bathroom_count,
	   sum(case when whycoffeeother='TRUE' then 1 else 0 end) whycoffeeother_count
	  from coffee
	  where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE')
select 'ittastesgood' as whycoffee, count, round((t2.count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'caffeine' as whycoffee, caffeine_count, round((t2.caffeine_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'ritual' as whycoffee, ritual_count, round((t2.ritual_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'bathroom' as whycoffee, bathroom_count, round((t2.bathroom_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
union all
select 'whycoffeeother' as whycoffee, whycoffeeother_count, round((t2.whycoffeeother_count::decimal*100/t1.total_count),2) as percentage
from t1, t2
order by percentage desc

------ maxpaid by cafe goers

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE'),
t2 as (select maxpaid, count(maxpaid) as count
from coffee
where atcafe='TRUE' and maxpaid is not null
group by coffee.maxpaid
order by count desc)
select maxpaid, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
order by count desc

---- maxpaid out of home

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE'),
t2 as (select maxpaid, count(maxpaid) as count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE' 
group by coffee.maxpaid
order by count desc)
select maxpaid, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
where maxpaid is not null
order by count desc

---- maxwilling cafe goers

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE'),
t2 as (select maxwilling, count(maxwilling) as count
from coffee
where atcafe='TRUE' and maxwilling is not null
group by coffee.maxwilling
order by count desc)
select maxwilling, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
order by count desc

---- maxwilling out of home

with t1 as (select distinct(count(submissionid)) as total_count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE' ),
t2 as (select maxwilling, count(maxwilling) as count
from coffee
where atcafe='TRUE' or atoffice='TRUE' or onthego='TRUE' 
group by coffee.maxwilling
order by count desc)
select maxwilling, count, round((t2.count*100/t1.total_count),2) || '%' as percentage
from t1, t2
where maxwilling is not null
order by count desc








































































































































































































