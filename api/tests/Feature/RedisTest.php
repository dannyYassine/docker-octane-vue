<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class RedisTest extends TestCase
{
    use DatabaseTransactions;

    public function test_set_and_get(): void
    {
        $firstGetResponse = $this->get('/api/redis/get');
        $setResponse = $this->get('/api/redis/set');
        $setResponse->assertOk();

        $getResponse = $this->get('/api/redis/get');

        $this->assertNull($firstGetResponse->json('data'));
        $this->assertNotNull($setResponse->json('data'));
        $this->assertNotNull($getResponse->json('data'));
    }
}
