import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
  UpdateDateColumn,
} from 'typeorm';
import { PrEmpleado } from './pr-empleado.entity';

@Entity('pr_usuario_login')
export class PrUsuarioLogin {
  @PrimaryGeneratedColumn({ name: 'usuario_id' })
  usuarioId: number;

  @Column({ name: 'empleado_id' })
  empleadoId: number;

  @Column({ name: 'nombre_usuario', length: 80, unique: true })
  nombreUsuario: string;

  @Column({ name: 'contrasena_hash', length: 255 })
  contrasenaHash: string;

  @Column({ name: 'esta_activo', default: true })
  estaActivo: boolean;

  @Column({ name: 'ultimo_ingreso_en', type: 'datetime', nullable: true })
  ultimoIngresoEn: Date | null;

  @CreateDateColumn({ name: 'creado_en' })
  creadoEn: Date;

  @UpdateDateColumn({ name: 'actualizado_en' })
  actualizadoEn: Date;

  @ManyToOne(() => PrEmpleado)
  @JoinColumn({ name: 'empleado_id' })
  empleado: PrEmpleado;
}
