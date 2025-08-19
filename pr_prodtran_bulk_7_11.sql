CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `pr_prodtran_bulk`(p_data text)
begin
-- 1st: check if p_data has a length of 0. If so then there should be an error
-- 2nd: create a variable for checking the beginning of the line begining_pos (to be initialized at 1) and the position of the line feed charcter "\n" lf_char_pos
-- 3rd: in the loop, update begining_pos = lf_char_pos + 1 and find the new position of the end position based on the substring starting from begining_pos to the end of the line.
	
    declare bgn_pos int default 0;
    declare lf_char_pos int default 0;
    declare v_line text;
    declare ctr int default 1;
    declare v_pid int;
    declare v_date date;
    declare v_quan int;
    declare v_price decimal(10,2);
    declare v_user text;
    declare this_delim int default 1;
    declare next_delim int;
    
    if char_length(p_data) = 0 then
		signal sqlstate '45000' set message_text = "dataset is null";
	end if;
    #p_pid	date	quantity	price	name
    
    set p_data = concat(p_data,'\n');
    
    -- 1st check if we extract some line
    
    -- check 4 lf character
    read_lines: loop
		set bgn_pos = lf_char_pos + 1;
        if (bgn_pos > char_length(p_data)) then
			leave read_lines;
		end if;
		set lf_char_pos = bgn_pos + locate('\n', substring(p_data,bgn_pos,char_length(p_data) )) - 1;
		set v_line = substring(p_data,bgn_pos,lf_char_pos - bgn_pos);
		select v_line;  
        -- read_line: loop
		set this_delim = 1;
		set next_delim = locate("	", v_line);
		set v_pid = cast(substring(v_line,this_delim,next_delim-this_delim) as signed);
		
		set this_delim = next_delim + 1;
		set next_delim = locate("	", substring(v_line,this_delim,char_length(v_line) ) );
		set v_date = cast(substring(v_line,this_delim, next_delim) as date);
		select v_date;
        -- select next_delim;
        select this_delim as this_delim_47, next_delim as next_delim_47;
		set this_delim = next_delim + 3;  
		set next_delim = locate("	", substring(v_line,this_delim,char_length(v_line) ) );     
        select substring(v_line,this_delim,char_length(v_line)) as fourth_pos, this_delim, next_delim;
		set v_quan = cast(substring(v_line,this_delim, next_delim) as signed); 
        
		
        -- select v_pid, v_date, v_quan;
        
        -- select this_delim this_ln_56, next_delim next_ln_56;
        
		set this_delim = this_delim + next_delim;  
		select this_delim this_delim_59;
		-- set this_delim = this_delim + next_delim;
        -- 4th delimiter
        -- select 60, this_delim;
		set next_delim = locate("	", substring(v_line, this_delim, char_length(v_line)));
        -- select this_delim this_delim_4th, next_delim next_delim_4th; 
        -- select 62 ln_62, this_delim, next_delim, substring(v_line,this_delim, next_delim-1), REGEXP_INSTR( substring(v_line,this_delim, next_delim), "[^0-9]" ); 
        if ((REGEXP_INSTR( substring(v_line,this_delim, next_delim - 1), "[^0123456789.+-]")) = 0 ) then #tab out of 0-9 so we dont want to include it
			set v_price = cast(substring(v_line,this_delim, next_delim) as decimal(10,2));
		end if;
        -- select 64;
        -- 5th delimiter
		set this_delim = this_delim + next_delim;
        select this_delim as this_delim_72, next_delim as next_delim_72;
        set v_user = substring(v_line,this_delim,char_length(v_line));
		-- set next_delim = locate("\n", );
        -- select this_delim, next_delim;
		-- set v_user = substring(v_line,this_delim, next_delim);
		
		select v_pid, v_date, v_quan, v_price, v_user;
		
        -- end loop read_line;
        set ctr = ctr + 1;
        if(ctr > 9) then
			leave read_lines;
		end if;
        
	end loop read_lines;
    
end