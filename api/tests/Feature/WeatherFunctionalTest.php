<?php

namespace Tests\Feature;

use Tests\TestCase;

class WeatherFunctionalTest extends TestCase
{
    public function test_get_weather(): void
    {
        $city = 'montreal';
        $response = $this->get('/api/weather/'.$city);

        $response->assertStatus(200);
    }
}
