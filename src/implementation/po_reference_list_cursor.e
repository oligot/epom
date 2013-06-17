note

	description:

		"Basic implementation of PO_CURSOR[G] using a DS_LINKED_LIST[PO_REFERENCE[G]]."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class PO_REFERENCE_LIST_CURSOR[G->PO_PERSISTENT]

inherit

	PO_CURSOR [G]
	
create

	make
	
feature -- Initialization

	make
			-- Creation routine.
		do
			create list.make
		end
		
feature -- Access

	item: G do Result := list.item_for_iteration.item end

	first : G do Result := list.first.item end
	
feature -- Measurement

	count : INTEGER do Result := list.count end
	
feature -- Status report

	after: BOOLEAN do Result := list.after end
	before: BOOLEAN do Result := list.before end
	off: BOOLEAN do Result := list.off end
	
feature -- Basic operations

	forth
		do
			list.forth
		end
		

	start
		do
			list.start
		end
		
feature {PO_ADAPTER} -- Element change

	add_reference (a_reference : PO_REFERENCE[G])
			-- Add `a_reference' into the collection.
		require
			a_reference_not_void: a_reference /= Void
		do
			list.put_last (a_reference)
		end
	
	add_object (object : G)
			-- Add `object' into the collection.
		require
			object_valid: object /= Void and object.is_persistent
		local
			a_reference : PO_REFERENCE[G]
		do
			create a_reference.set_item (object)
			add_reference (a_reference)
		end
	
	add_last_pid (adapter : PO_ADAPTER[G])
			-- Add `adapter.last_pid' into the collection.
		require
			last_pid_valid: adapter /= Void and then adapter.last_pid /= Void
		local
			a_reference : PO_REFERENCE [G]
		do
			create a_reference.set_pid_from_adapter (adapter)
			add_reference (a_reference)
		end

	wipe_out
			-- Wipe out elements.
		do
			list.wipe_out
		ensure
			empty: is_empty
		end
		
feature {NONE} -- Implementation

	list : DS_LINKED_LIST[PO_REFERENCE[G]]
	
invariant

	list_not_void: list /= Void

end
