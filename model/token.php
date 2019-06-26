<?php
namespace Model;

class Token {
    private $db;

    public function __construct() {
        $dotenv = \Dotenv\Dotenv::create(dirname(__DIR__));
        $dotenv->load();
        $host = getenv('DB_HOST');
        $port = getenv('DB_PORT');
        $user = getenv('DB_USER');
        $pass = getenv('DB_PASS');
        $dbname = getenv('DB_NAME');
        $dbscheme = 'mysql';
        $pdo = new \PDO($dbscheme . ':' . 'dbname=' . $dbname . ';host=' . $host . ':' . $port . ';', $user, $pass);
        $this->db = new \LessQL\Database($pdo);
    }

    public function save($key, $token) {
        return $this->db->createRow('tokens', array(
            'key' => $key,
            'token' => $token,
        ))->save();
    }

    public function read($key) {
        $tokens = $this->db->table('tokens')
                ->orderBy('token', 'DESC')->fetchAll();
        $result = '';
        foreach ($tokens as $t) {
            if ($t['key'] === $key) {
                $result = $t;
            }
        }
        return $result;
    }
}
