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
        // $pdo = new \PDO($dbscheme . ':' . 'dbname=' . $dbname . ';host=' . $host . ':' . $port . ';', $user, $pass);
        $pdo = new \PDO("sqlite:/" . dirname(__DIR__) . "/tokens.sqlite3");
        $this->db = new \LessQL\Database($pdo);
    }

    public function save($key, $value) {
        return $this->db->createRow('tokens', array(
            'key' => $key,
            'value' => $value,
        ))->save();
    }

    public function list() {
        $tokens = $this->db->table('tokens')
                ->orderBy('value', 'DESC')->orderBy('key', 'DESC')->fetchAll();
        return $tokens;
    }

    public function delete($token) {
        $token->delete();
    }
}
