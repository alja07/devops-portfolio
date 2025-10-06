# Отчет по части 7. Прометей и Графана

## Prometheus и Grafana на виртуальной машине.
Проверяем версию Grafana на виртуальной машине (далее ВМ):
```bash
grafana-server -v
```
![версия Grafana](img/grafana-v.png)

Проверяем статус Grafana:  
```bash
sudo systemctl status grafana-server
```
![Статус Grafana](img/grafana-status.png)

Проверяем, слушает ли порт 3000:  
```bash
sudo ss -tlnp | grep 3000
```
![Порт Grafana](img/grafana-port.png)

Проверяем версию Prometheus на виртуальной машине (далее ВМ):
```bash
prometheus --version
```
![версия Prometheus](img/prometheus-version.png)

Проверяем статус Prometheus:  
```bash
sudo systemctl status prometheus
```
![Статус Prometheus](img/prometheus-status.png)

Проверяем, слушает ли порт 3000:  
```bash
sudo ss -tlnp | grep 3000
```
![Порт Prometheus](img/grafana-port.png)

Grafana с локального ПК в браузере c панелю инструментов: отображение загрузки ЦП, доступная оперативная память, место на жестком диске:
![Grafana с локального ПК](img/grafana-local.png)

Prometheus с локального ПК в браузере:
![Prometheus с локального ПК](img/prometheus-local.png)

Запускаем скрипт из части 2 и наблюдаем, как изменились показатели в Grafana:
```bash
sudo ./main.sh az az.az 3Mb
```

![показатели в Grafana после запуска скрипта из части 2](img/grafana-local-script2.png)


> Метрики жесткого диска:
>- Root FS Used - % использованного места на основном жестком диске (где установлена система)
>- Disk I/O Operations - количество операций чтения/записи в секунду
>- Disk Throughput - объем данных, читаемых/записываемых в мегабайтах в секунду (пропускная спобоность)
>- Disk Space Usage - использование места по точкам монтирования
>- Filesystem Space Available - свободное место

![показатели в Grafana жесткого диска](img/disk.png)

Метрики после теста:
```bash
sudo stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s

```

![показатели в Grafana тест stress](img/stress.png)

