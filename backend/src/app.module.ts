import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppInfoModule } from './modules/app-info/app-info.module';
import { AuthModule } from './modules/auth/auth.module';
import { HealthModule } from './modules/health/health.module';
import { UsersModule } from './modules/users/users.module';
import { User } from './modules/users/user.entity';
import { PrEmpleado } from './modules/rrhh/entities/pr-empleado.entity';
import { PrEmpleadoRol } from './modules/rrhh/entities/pr-empleado-rol.entity';
import { PrPersona } from './modules/rrhh/entities/pr-persona.entity';
import { PrRol } from './modules/rrhh/entities/pr-rol.entity';
import { PrUsuarioLogin } from './modules/rrhh/entities/pr-usuario-login.entity';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: process.env.DB_HOST || 'mysql',
      port: Number(process.env.DB_PORT || 3306),
      username: process.env.DB_USERNAME || 'root',
      password: process.env.DB_PASSWORD ?? '',
      database: process.env.DB_DATABASE || 'abcmudanzas',
      entities: [User, PrPersona, PrEmpleado, PrRol, PrEmpleadoRol, PrUsuarioLogin],
      synchronize: false,
    }),
    HealthModule,
    AppInfoModule,
    AuthModule,
    UsersModule,
  ],
})
export class AppModule {}