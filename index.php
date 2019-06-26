<?php declare(strict_types=1);

include __DIR__ . '/vendor/autoload.php';

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;

\Liquid\Liquid::set('INCLUDE_PREFIX', '');

$request = Zend\Diactoros\ServerRequestFactory::fromGlobals(
    $_SERVER, $_GET, $_POST, $_COOKIE, $_FILES
);

$router = new League\Route\Router;

$router->map('GET', '/', function (ServerRequestInterface $request) : ResponseInterface {
    $response = new Zend\Diactoros\Response;
    $template = new \Liquid\Template(__DIR__ . '/view');
    $template->setCache(new \Liquid\Cache\Local());
    $token = new Model\Token();

    $tokens = $token->list();
    foreach ($tokens as $t) {
        $token->delete($t);
    }

    $params = $request->getQueryParams();

    foreach ($params as $key => $value) {
        $token->save($key, $value);
    }
    $tokens = $token->list();

    $reversed = '';
    if (array_key_exists(2, $tokens)) {
        $t = $tokens[2]->value;
        for($i = strlen($t) - 1; $i >= 0; $i--) {
            $reversed = $reversed . $t[$i];
        }
    }

    $rendered = $template->parseFile('home')->render(array('reversed' => $reversed));
    $response->getBody()->write($rendered);
    return $response;
});

$response = $router->dispatch($request);

(new Zend\HttpHandlerRunner\Emitter\SapiEmitter)->emit($response);
