import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  OneToOne,
  CreateDateColumn,
  UpdateDateColumn,
} from 'typeorm';
import { PrEmpleado } from './pr-empleado.entity';

@Entity('pr_persona')
export class PrPersona {
  @PrimaryGeneratedColumn({ name: 'persona_id' })
  personaId: number;

  @Column({ name: 'tipo_documento', type: 'varchar', length: 20 })
  tipoDocumento: string;

  @Column({ name: 'numero_documento', type: 'varchar', length: 30, unique: true })
  numeroDocumento: string;

  @Column({ name: 'nombres', type: 'varchar', length: 80 })
  nombres: string;

  @Column({ name: 'apellidos', type: 'varchar', length: 80 })
  apellidos: string;

  @Column({ name: 'correo_electronico', type: 'varchar', length: 120, nullable: true })
  correoElectronico?: string;

  @Column({ name: 'telefono', type: 'varchar', length: 30, nullable: true })
  telefono?: string;

  @Column({ name: 'esta_activo', type: 'boolean', default: true })
  estaActivo: boolean;

  @CreateDateColumn({ name: 'creado_en' })
  creadoEn: Date;

  @UpdateDateColumn({ name: 'actualizado_en' })
  actualizadoEn: Date;

  @OneToOne(() => PrEmpleado, (empleado) => empleado.persona)
  empleado: PrEmpleado;
}