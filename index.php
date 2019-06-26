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
    $rendered = $template->parseFile('home')->render();
    $response->getBody()->write($rendered);
    return $response;
});

$response = $router->dispatch($request);

(new Zend\HttpHandlerRunner\Emitter\SapiEmitter)->emit($response);
