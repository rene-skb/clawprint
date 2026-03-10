const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);

module.exports = async (req, res) => {
  if (req.method !== 'GET') {
    res.setHeader('Allow', 'GET');
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { session_id } = req.query;
  if (!session_id) {
    return res.status(400).json({ error: 'Missing session_id' });
  }

  try {
    const session = await stripe.checkout.sessions.retrieve(session_id);

    if (session.payment_status === 'paid') {
      res.json({
        paid: true,
        downloadUrl: '/clawprint-v1.0.zip',
        email: session.customer_details?.email || null,
      });
    } else {
      res.json({ paid: false });
    }
  } catch (err) {
    console.error('Verify error:', err.message);
    res.status(400).json({ error: 'Invalid session' });
  }
};
