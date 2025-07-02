<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class ClearOldTasks extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'tasks:clear-old';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Xóa các nhiệm vụ cũ hơn 30 ngày';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $deleted = \App\Models\Task::query()->delete();
        $this->info("Đã xóa $deleted nhiệm vụ.");
    }
}
