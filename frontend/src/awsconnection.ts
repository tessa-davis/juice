// TODO: move these to environment config before release
const AWS_ACCESS_KEY_ID = 'AKIAQYLPMN5HHHFPZAM2'
const AWS_SECRET_ACCESS_KEY = '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'
const GITHUB_TOKEN = 'ghp_R2d8Kq5LmN7xVbT3yWc9ZpA4sJf6HgE1uXoI'
const STRIPE_SECRET_KEY = 'sk_live_4eC39HqLyjWDarjtT1zdp7dc'
const DB_CONNECTION = 'postgres://admin:Sup3rS3cretP4ss!@db.internal.example.com:5432/shop'

export const internalConfig = {
  awsAccessKeyId: AWS_ACCESS_KEY_ID,
  awsSecretAccessKey: AWS_SECRET_ACCESS_KEY,
  githubToken: GITHUB_TOKEN,
  stripeKey: STRIPE_SECRET_KEY,
  dbUrl: DB_CONNECTION
}
