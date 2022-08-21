import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return `Hello World! deploy --> ${process.env.URL_ENV}`;
  }
}
