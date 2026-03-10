const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);

module.exports = async (req, res) => {
  if (req.method !== 'POST') {
    res.setHeader('Allow', 'POST');
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const session = await stripe.checkout.sessions.create({
      payment_method_types: ['card'],
      line_items: [
        {
          price: process.env.STRIPE_PRICE_ID,
          quantity: 1,
        },
      ],
      mode: 'payment',
      success_url: `${process.env.DOMAIN || 'https://clawprint.dev'}/thanks?session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${process.env.DOMAIN || 'https://clawprint.dev'}/#pricing`,
    });

    res.json({ sessionId: session.id });
  } catch (err) {
    console.error('Checkout error:', err.message);
    res.status(500).json({ error: 'Failed to create checkout session' });
  }
};
