<?php

class selectDb {
	static private $_instance;
	static private $_connectSource;
	private $_dbConfig = array(
		'host' => '127.0.0.1',
		'user' => 'root',
		'password' => '123456',
		'database' => 'st_inner_erp',
	);

	private function __construct() {
	}

	static public function getInstance() {
		if(!(self::$_instance instanceof self)) {
			self::$_instance = new self();
		}
		return self::$_instance;
	}

	public function connect() {
		if(!self::$_connectSource) {
			self::$_connectSource = @mysqli_connect($this->_dbConfig['host'], $this->_dbConfig['user'], $this->_dbConfig['password']);

			if(!self::$_connectSource) {
				throw new Exception('mysql connect error ' . mysqli_error());
				//die('mysql connect error' . mysql_error());
			}
			
			mysqli_select_db(self::$_connectSource,$this->_dbConfig['database']);
			mysqli_query(self::$_connectSource,"set names UTF8");
		}
		return self::$_connectSource;
	}
}
