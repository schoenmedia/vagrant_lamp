
class admin::user( $user, $group,$uid,$gid) {

	


	group { "${group}":
    	gid    => $apache_chown[0]['gid'], 
	}

	
	@user {
  		 "${user}":
    		uid =>  $uid,
    		gid => $gid,
	}

	realize ( User[$user])
}