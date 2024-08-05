select * from medicine
 
select * from sale_medicine

insert into sale_medicine (product_name,batch,qty,product_id)
values
('omnigel','om125s1',5,'o1')
 
select 5 * 150

select sum(s.qty) * sum(m.mrp) as "total_sale" from sale_medicine as s
inner join medicine as m 
on m.product_id = s.product_id
where s.product_id = 'o1'

update medicine set total_sale = 750

CREATE OR REPLACE FUNCTION update_total_sale ()
RETURNS TRIGGER AS $$
DECLARE 
	ts int;
		BEGIN
			select sum(s.qty) * sum(m.mrp) into ts from sale_medicine as s
			inner join medicine as m 
			on m.product_id = s.product_id
			where s.product_id = NEW.product_id;

			update medicine set total_sale = ts
			where product_id =  NEW.product_id;
	RETURN NEW;
		END
$$ LANGUAGE plpgsql;
			
CREATE TRIGGER trigger_update_total_sale
AFTER INSERT ON sale_medicine
FOR EACH ROW
EXECUTE FUNCTION update_total_sale ()

insert into sale_medicine (product_name,batch,qty,product_id)
values
('panderm','psa124',2,'p8')
 
select * from medicine




