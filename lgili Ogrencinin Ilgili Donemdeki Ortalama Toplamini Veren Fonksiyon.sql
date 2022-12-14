USE [Okul]

--lgili Ogrencinin Ilgili Donemdeki Ortalama Toplamini Veren Fonksiyon:

create function [dbo].[FN$IlgiliOgrencininIlgiliDonemdekiOrtalamaToplami](@Ogrenci_Id int,@Donem_Id int)
returns int
as
begin
declare @sonuc as int


set  @sonuc = (select sum(b.ortalama)  from
(select  d.Id as ders , (ood.Vize*0.4+ood.Final*0.6) as ortalama,do.Id as güzdönemi from dbo.OgrenciOgretmenDers as ood 
inner join dbo.OgretmenDers as od on od.Id=ood.OgretmenDers_Id and od.Statu=1
inner join dbo.Ders as d on d.Id=od.Ders_Id and d.Statu=1
inner join dbo.Ogrenci as o on o.Id=ood.Ogrenci_Id and o.Statu=1
inner join dbo.Donem as do on do.Id=od.Donem_Id and do.Statu=1
where 
ood.Statu=1
and
od.Donem_Id=1
and do.Id = @Donem_Id
and ood.Ogrenci_Id=@Ogrenci_Id
group by d.Id,ood.Vize*0.4+ood.Final*0.6,do.Id) b
group by b.ders,b.güzdönemi)


return @sonuc
end


--cagiralim:
select [dbo].[FN$IlgiliOgrencininIlgiliDonemdekiOrtalamaToplami](12,1)


--where clause kontrolu:
select convert(int,round(sum(b.ortalama),0)) from
(select  d.Id as ders , (ood.Vize*0.4+ood.Final*0.6) as ortalama,do.Id as güzdönemi from dbo.OgrenciOgretmenDers as ood 
inner join dbo.OgretmenDers as od on od.Id=ood.OgretmenDers_Id and od.Statu=1
inner join dbo.Ders as d on d.Id=od.Ders_Id and d.Statu=1
inner join dbo.Ogrenci as o on o.Id=ood.Ogrenci_Id and o.Statu=1
inner join dbo.Donem as do on do.Id=od.Donem_Id and do.Statu=1
where 
ood.Statu=1
and
od.Donem_Id=1
and do.Id = 1
and ood.Ogrenci_Id=12
group by d.Id,ood.Vize*0.4+ood.Final*0.6,do.Id) b
group by b.ders,b.güzdönemi
