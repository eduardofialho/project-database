PGDMP                  	    |            database    17.0    17.0     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16388    database    DATABASE     �   CREATE DATABASE database WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE database;
                     postgres    false            �            1259    16417    appointments    TABLE     O  CREATE TABLE public.appointments (
    id integer NOT NULL,
    student_id integer,
    teacher_id integer,
    appointment_date date NOT NULL,
    start_time time with time zone NOT NULL,
    end_time time with time zone NOT NULL,
    status character varying(20) DEFAULT 'scheduled'::character varying,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT check_status CHECK (((status)::text = ANY ((ARRAY['scheduled'::character varying, 'cancelled'::character varying, 'completed'::character varying])::text[])))
);
     DROP TABLE public.appointments;
       public         heap r       postgres    false            �            1259    16402    availability    TABLE     j  CREATE TABLE public.availability (
    id integer NOT NULL,
    user_id integer,
    day_of_week character varying(9),
    start_time time with time zone NOT NULL,
    end_time time with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT check_day_of_week CHECK (((day_of_week)::text = ANY ((ARRAY['Monday'::character varying, 'Tuesday'::character varying, 'Wednesday'::character varying, 'Thursday'::character varying, 'Friday'::character varying, 'Saturday'::character varying, 'Sunday'::character varying])::text[])))
);
     DROP TABLE public.availability;
       public         heap r       postgres    false            �            1259    16401    appointments_id_seq    SEQUENCE     �   CREATE SEQUENCE public.appointments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.appointments_id_seq;
       public               postgres    false    220            �           0    0    appointments_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.appointments_id_seq OWNED BY public.availability.id;
          public               postgres    false    219            �            1259    16416    appointments_id_seq1    SEQUENCE     �   CREATE SEQUENCE public.appointments_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.appointments_id_seq1;
       public               postgres    false    222            �           0    0    appointments_id_seq1    SEQUENCE OWNED BY     L   ALTER SEQUENCE public.appointments_id_seq1 OWNED BY public.appointments.id;
          public               postgres    false    221            �            1259    16390    users    TABLE     �  CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    user_type character varying(10),
    created_at timestamp with time zone DEFAULT now(),
    "updated_at " timestamp with time zone DEFAULT now(),
    CONSTRAINT user_type_check CHECK (((user_type)::text = ANY ((ARRAY['teacher'::character varying, 'student'::character varying])::text[])))
);
    DROP TABLE public.users;
       public         heap r       postgres    false            �            1259    16389    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public               postgres    false    218            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public               postgres    false    217            1           2604    16420    appointments id    DEFAULT     s   ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq1'::regclass);
 >   ALTER TABLE public.appointments ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221    222            .           2604    16405    availability id    DEFAULT     r   ALTER TABLE ONLY public.availability ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);
 >   ALTER TABLE public.availability ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    219    220    220            +           2604    16393    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    217    218    218            �          0    16417    appointments 
   TABLE DATA           �   COPY public.appointments (id, student_id, teacher_id, appointment_date, start_time, end_time, status, created_at, updated_at) FROM stdin;
    public               postgres    false    222   �%       �          0    16402    availability 
   TABLE DATA           n   COPY public.availability (id, user_id, day_of_week, start_time, end_time, created_at, updated_at) FROM stdin;
    public               postgres    false    220   &       �          0    16390    users 
   TABLE DATA           e   COPY public.users (id, name, email, password_hash, user_type, created_at, "updated_at ") FROM stdin;
    public               postgres    false    218   3&       �           0    0    appointments_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.appointments_id_seq', 1, false);
          public               postgres    false    219            �           0    0    appointments_id_seq1    SEQUENCE SET     C   SELECT pg_catalog.setval('public.appointments_id_seq1', 1, false);
          public               postgres    false    221            �           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 1, false);
          public               postgres    false    217            ?           2606    16426    appointments appointments_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.appointments DROP CONSTRAINT appointments_pkey;
       public                 postgres    false    222            =           2606    16410    availability availability_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.availability
    ADD CONSTRAINT availability_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.availability DROP CONSTRAINT availability_pkey;
       public                 postgres    false    220            9           2606    16398    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public                 postgres    false    218            ;           2606    16396    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 postgres    false    218            A           2606    16427 '   appointments fk_appointments_student_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT fk_appointments_student_id FOREIGN KEY (student_id) REFERENCES public.users(id) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.appointments DROP CONSTRAINT fk_appointments_student_id;
       public               postgres    false    4667    218    222            B           2606    16432 '   appointments fk_appointments_teacher_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT fk_appointments_teacher_id FOREIGN KEY (teacher_id) REFERENCES public.users(id);
 Q   ALTER TABLE ONLY public.appointments DROP CONSTRAINT fk_appointments_teacher_id;
       public               postgres    false    222    4667    218            @           2606    16411 $   availability fk_availability_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.availability
    ADD CONSTRAINT fk_availability_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.availability DROP CONSTRAINT fk_availability_user_id;
       public               postgres    false    218    4667    220            �      x������ � �      �      x������ � �      �      x������ � �     