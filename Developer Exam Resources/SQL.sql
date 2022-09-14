FOR lrContact IN SELECT ID,FirstName,LastName from ffContact WHERE ID IN (1,2,3) LOOP
	if length(lrContact.LastName)>0 THEN
		if length(lrContact.FirstName)>0 THEN
			lcName := lrContact.FirstName||' '||lrContact.LastName;
		ELSE
			lcName := lrContact.LastName;
		END IF;
	ELSE
		lcName := lrContact.FirstName;
	END IF;
	UPDATE ffContact SET FullName=lcName WHERE ID=lrContact.ID
END LOOP;