# Database seeds

# Creates users
User.create(name: 'John Doe', email: 'john@clicksign.com', password: 'foobar123', token_issued_at: Time.current)

# Create Stages

Stage.create(name: 'Fase de Grupos (Rodada 1)')
Stage.create(name: 'Fase de Grupos (Rodada 2)')
Stage.create(name: 'Fase de Grupos (Rodada 3)')
Stage.create(name: 'Oitavas de final')
Stage.create(name: 'Quartas de final')
Stage.create(name: 'Semi-finais')
Stage.create(name: 'Final')

# Create Teams

# Group A
Team.create(name: 'Catar')
Team.create(name: 'Equador')
Team.create(name: 'Senegal')
Team.create(name: 'Holanda')

# Group B
Team.create(name: 'Inglaterra')
Team.create(name: 'Irã')
Team.create(name: 'Estados Unidos')
Team.create(name: 'Gales')

# Group C
Team.create(name: 'Argentina')
Team.create(name: 'Arábia Saudita')
Team.create(name: 'México')
Team.create(name: 'Polônia')

# Group D
Team.create(name: 'França')
Team.create(name: 'Austrália')
Team.create(name: 'Dinamarca')
Team.create(name: 'Tunísia')

# Group E
Team.create(name: 'Espanha')
Team.create(name: 'Costa Rica')
Team.create(name: 'Alemanha')
Team.create(name: 'Japão')

# Group F
Team.create(name: 'Bélgica')
Team.create(name: 'Canadá')
Team.create(name: 'Marrocos')
Team.create(name: 'Croácia')

# Group G
Team.create(name: 'Brasil')
Team.create(name: 'Sérvia')
Team.create(name: 'Suíça')
Team.create(name: 'Camarões')

# Group H
Team.create(name: 'Portugal')
Team.create(name: 'Gana')
Team.create(name: 'Uruguai')
Team.create(name: 'Coreia do Sul')
