import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { HttpExceptionFilter } from "./common/filter/http-exception/http-exception.filter";
import { TransformInterceptor } from "./common/interceptor/transform/transform.interceptor";
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import * as express from 'express';
import { join } from 'path';
async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.useGlobalFilters(new HttpExceptionFilter());
  app.useGlobalInterceptors(new TransformInterceptor());
  const options = new DocumentBuilder()
    .setTitle('API 文档')
    .setDescription('API 文档描述')
    .setVersion('1.0')
    .build();

  const document = SwaggerModule.createDocument(app, options);
  SwaggerModule.setup('blog-api', app, document);

  await app.listen(3000);
}
bootstrap();
