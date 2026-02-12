using Microsoft.AspNetCore.Mvc;
using System;
using System.Diagnostics;

namespace CpuSpiker.Controllers
{
    [ApiController]
    [Route("")]
    public class SpikeController : ControllerBase
    {
        [HttpGet("spike")]
        public IActionResult SpikeCpu()
        {
            // Deliberately consume CPU to trigger the alert
            var watch = Stopwatch.StartNew();
            while (watch.ElapsedMilliseconds < 10000) // Spin for 10 seconds
            {
                _ = Math.Sqrt(new Random().NextDouble());
            }
            return Ok("CPU Spiked!");
        }
    }
}
