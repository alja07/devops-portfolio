#include <fcgi_stdio.h>
#include <stdlib.h>

int main() {
  // Количество запросов для обработки
  while (FCGI_Accept() >= 0) {
    // Заголовок HTTP ответа
    printf("Content-type: text/html\r\n");
    printf("\r\n"); // Пустая строка между заголовками и телом

    // Тело HTML страницы
    printf("<!DOCTYPE html>");
    printf("<html>");
    printf("<head>");
    printf("<title>Hello, World!</title>");
    printf("</head>");
    printf("<body>");
    printf("<h1>Hello, World!</h1>");
    printf("<p>This is a simple FastCGI server!</p>");
    printf("</body>");
    printf("</html>");
  }
  return 0;
}