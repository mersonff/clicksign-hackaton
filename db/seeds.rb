# Database seeds

# Creates users
User.create(name: 'John Doe', email: 'john@clicksign.com', password: 'foobar123', token_issued_at: Time.current)

Stage.create(name: 'Fase de Grupos (Rodada 1)')

Team.create(name: 'Brasil', description: 'Seleção Canarinho')
Team.create(name: 'Argentina', description: 'La mano de Dios')
