    # Генерация HTML
    cat > "$HTML_FILE" <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>LinuxMonitoring v2.0 | Part 9</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --cpu-color: #0066cc;
            --ram-color: #cc0066;
            --disk-color: #4bc0c0;
            --swap-color: #ff9f40;
            --network-color: #9966ff;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background: #f5f7fa;
            color: #333;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e1e4e8;
        }
        .header h1 {
            color: #2c3e50;
            margin: 0;
            font-size: 2.2em;
        }
        .header h2 {
            color: #7f8c8d;
            margin: 5px 0 0;
            font-size: 1.2em;
            font-weight: normal;
        }
        .dashboard {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }
        .card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .card h3 {
            margin-top: 0;
            color: #2c3e50;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .chart-container {
            width: 100%;
            height: 200px;
            margin-bottom: 15px;
        }
        .metric-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }
        .metric {
            font-size: 14px;
            padding: 8px;
            background: #f8f9fa;
            border-radius: 4px;
        }
        .metric-label {
            font-weight: 600;
            color: #7f8c8d;
            display: block;
            margin-bottom: 3px;
            font-size: 0.9em;
        }
        .metric-value {
            font-weight: bold;
            font-size: 1.1em;
        }
        .critical { color: #e74c3c; }
        .warning { color: #f39c12; }
        .good { color: #27ae60; }
        .progress-container {
            width: 100%;
            background: #ecf0f1;
            border-radius: 4px;
            margin: 10px 0;
            height: 10px;
        }
        .progress-bar {
            height: 100%;
            border-radius: 4px;
        }
        .info-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        .info-table td {
            padding: 8px 0;
            border-bottom: 1px solid #eee;
        }
        .info-table tr:last-child td {
            border-bottom: none;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>LinuxMonitoring v2.0</h1>
        <h2>Part 9 - System Metrics Dashboard</h2>
    </div>

    <div class="dashboard">
        <!-- CPU Card -->
        <div class="card">
            <h3>Processor</h3>
            <div class="chart-container">
                <canvas id="cpuChart"></canvas>
            </div>
            <div class="progress-container">
                <div id="cpuProgress" class="progress-bar" style="width: 0%; background: var(--cpu-color);"></div>
            </div>
            <div class="metric-grid">
                <div class="metric">
                    <span class="metric-label">Usage</span>
                    <span id="cpuUsage" class="metric-value">0%</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Cores</span>
                    <span id="cpuCores" class="metric-value">0</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Load (1m)</span>
                    <span id="cpuLoad" class="metric-value">0</span>
                </div>
            </div>
        </div>

        <!-- RAM Card -->
        <div class="card">
            <h3>Memory</h3>
            <div class="chart-container">
                <canvas id="ramChart"></canvas>
            </div>
            <div class="progress-container">
                <div id="ramProgress" class="progress-bar" style="width: 0%; background: var(--ram-color);"></div>
            </div>
            <table class="info-table">
                <tr>
                    <td>Used:</td>
                    <td><span id="ramUsed" class="metric-value">0 MB</span></td>
                </tr>
                <tr>
                    <td>Free:</td>
                    <td><span id="ramFree" class="metric-value">0 MB</span></td>
                </tr>
                <tr>
                    <td>Total:</td>
                    <td><span id="ramTotal" class="metric-value">0 MB</span></td>
                </tr>
                <tr>
                    <td>Swap:</td>
                    <td><span id="swapUsed" class="metric-value">0 MB</span> / <span id="swapTotal">0 MB</span></td>
                </tr>
            </table>
        </div>

        <!-- Disk Card -->
        <div class="card">
            <h3>Storage</h3>
            <div class="chart-container">
                <canvas id="diskPieChart"></canvas>
            </div>
            <div class="progress-container">
                <div id="diskProgress" class="progress-bar" style="width: 0%; background: var(--disk-color);"></div>
            </div>
            <table class="info-table">
                <tr>
                    <td>Used:</td>
                    <td><span id="diskUsed" class="metric-value">0 MB</span></td>
                </tr>
                <tr>
                    <td>Free:</td>
                    <td><span id="diskFree" class="metric-value">0 MB</span></td>
                </tr>
                <tr>
                    <td>Total:</td>
                    <td><span id="diskTotal" class="metric-value">0 MB</span></td>
                </tr>
                <tr>
                    <td>Inodes:</td>
                    <td><span id="inodesUsed" class="metric-value">0</span> / <span id="inodesFree">0</span></td>
                </tr>
            </table>
        </div>

        <!-- Network Card -->
        <div class="card">
            <h3>Network</h3>
            <div class="chart-container">
                <canvas id="networkChart"></canvas>
            </div>
            <table class="info-table">
                <tr>
                    <td>Received:</td>
                    <td><span id="networkRx" class="metric-value">0 B</span></td>
                </tr>
                <tr>
                    <td>Transmitted:</td>
                    <td><span id="networkTx" class="metric-value">0 B</span></td>
                </tr>
            </table>
        </div>

        <!-- System Info Card -->
        <div class="card">
            <h3>System Information</h3>
            <table class="info-table">
                <tr>
                    <td>Hostname:</td>
                    <td><span id="hostname" class="metric-value">-</span></td>
                </tr>
                <tr>
                    <td>Uptime:</td>
                    <td><span id="uptime" class="metric-value">-</span></td>
                </tr>
                <tr>
                    <td>Last Update:</td>
                    <td><span id="lastUpdate" class="metric-value">-</span></td>
                </tr>
            </table>
        </div>
    </div>

    <script>
        // Инициализация графиков
        const cpuChart = new Chart(
            document.getElementById('cpuChart').getContext('2d'),
            {
                type: 'line',
                data: {
                    datasets: [{
                        label: 'CPU Usage (%)',
                        borderColor: 'var(--cpu-color)',
                        backgroundColor: 'rgba(0, 102, 204, 0.1)',
                        borderWidth: 2,
                        pointRadius: 0,
                        tension: 0.3,
                        data: []
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: { min: 0, max: 100 },
                        x: { display: false }
                    },
                    plugins: { legend: { display: false } }
                }
            }
        );

        const ramChart = new Chart(
            document.getElementById('ramChart').getContext('2d'),
            {
                type: 'line',
                data: {
                    datasets: [{
                        label: 'RAM Usage (%)',
                        borderColor: 'var(--ram-color)',
                        backgroundColor: 'rgba(204, 0, 102, 0.1)',
                        borderWidth: 2,
                        pointRadius: 0,
                        tension: 0.3,
                        data: []
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: { min: 0, max: 100 },
                        x: { display: false }
                    },
                    plugins: { legend: { display: false } }
                }
            }
        );

        const diskPieChart = new Chart(
            document.getElementById('diskPieChart').getContext('2d'),
            {
                type: 'pie',
                data: {
                    labels: ['Used', 'Free'],
                    datasets: [{
                        data: [0, 100],
                        backgroundColor: [
                            'var(--disk-color)',
                            'rgba(75, 192, 192, 0.2)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            }
        );

        const networkChart = new Chart(
            document.getElementById('networkChart').getContext('2d'),
            {
                type: 'bar',
                data: {
                    labels: ['Received', 'Transmitted'],
                    datasets: [{
                        label: 'Network Traffic',
                        data: [0, 0],
                        backgroundColor: [
                            'rgba(153, 102, 255, 0.7)',
                            'rgba(153, 102, 255, 0.4)'
                        ],
                        borderColor: [
                            'var(--network-color)',
                            'var(--network-color)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { display: false } },
                    scales: {
                        y: { beginAtZero: true }
                    }
                }
            }
        );

        // Функция обновления данных
        async function updateMetrics() {
            try {
                const response = await fetch('/metrics/api.json');
                const data = await response.json();
                
                // Обновляем системную информацию
                document.getElementById('hostname').textContent = data.system.hostname;
                document.getElementById('uptime').textContent = data.system.uptime;
                document.getElementById('lastUpdate').textContent = data.system.time;
                
                // CPU
                document.getElementById('cpuUsage').textContent = data.cpu.usage + '%';
                document.getElementById('cpuCores').textContent = data.cpu.cores;
                document.getElementById('cpuLoad').textContent = data.cpu.load;
                document.getElementById('cpuProgress').style.width = data.cpu.usage + '%';
                
                // RAM
                document.getElementById('ramUsed').textContent = data.ram.used + ' MB';
                document.getElementById('ramFree').textContent = data.ram.free + ' MB';
                document.getElementById('ramTotal').textContent = data.ram.total + ' MB';
                document.getElementById('swapUsed').textContent = data.ram.swap_used + ' MB';
                document.getElementById('swapTotal').textContent = data.ram.swap_total + ' MB';
                document.getElementById('ramProgress').style.width = data.ram.percent + '%';
                
                // Disk
                document.getElementById('diskUsed').textContent = data.disk.used + ' MB';
                document.getElementById('diskFree').textContent = data.disk.free + ' MB';
                document.getElementById('diskTotal').textContent = data.disk.total + ' MB';
                document.getElementById('inodesUsed').textContent = data.disk.inodes_used;
                document.getElementById('inodesFree').textContent = data.disk.inodes_free;
                document.getElementById('diskProgress').style.width = data.disk.percent + '%';
                
                // Network
                document.getElementById('networkRx').textContent = data.network.rx;
                document.getElementById('networkTx').textContent = data.network.tx;
                
                // Обновляем графики
                updateChart(cpuChart, data.timestamps, data.cpu.history);
                updateChart(ramChart, data.timestamps, data.ram.history);
                
                // Обновляем круговую диаграмму
                diskPieChart.data.datasets[0].data = [data.disk.percent, 100 - data.disk.percent];
                diskPieChart.update();
                
                // Обновляем сетевой график
                networkChart.data.datasets[0].data = [
                    parseFloat(data.network.rx),
                    parseFloat(data.network.tx)
                ];
                networkChart.update();
                
                // Добавляем классы предупреждений
                updateWarningClass('cpuUsage', data.cpu.usage);
                updateWarningClass('ramUsed', data.ram.percent);
                updateWarningClass('diskUsed', data.disk.percent);
                updateWarningClass('swapUsed', (data.ram.swap_used / data.ram.swap_total * 100).toFixed(1));
                
            } catch (error) {
                console.error('Error fetching metrics:', error);
            }
        }
        
        function updateChart(chart, labels, data) {
            chart.data.labels = labels;
            chart.data.datasets[0].data = data;
            chart.update();
        }
        
        function updateWarningClass(elementId, value) {
            const element = document.getElementById(elementId);
            element.classList.remove('critical', 'warning', 'good');
            
            if (value > 90) {
                element.classList.add('critical');
            } else if (value > 70) {
                element.classList.add('warning');
            } else {
                element.classList.add('good');
            }
        }
        
        // Обновляем каждые 5 секунд
        updateMetrics();
        setInterval(updateMetrics, 5000);
    </script>
</body>
</html>
EOF

    sleep 5
