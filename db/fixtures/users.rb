
User.seed_once(:id, :email,
  {id: 1, email: 'andres.berrios.j@gmail.com', password: 'holahola', role: 'admin'},
  {id: 2, email: 'rodolfo.faundez@smarket.cl', password: 'holahola', role: 'admin'},
  {id: 3, email: 'felipe.urbina@smarket.cl', password: 'holahola', role: 'admin'}
)
