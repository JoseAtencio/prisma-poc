import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()
async function main() {
    await prisma.claims.upsert({
    where: {id: 1},
    update: {},
    create: {
        "carrier_claim_number": "CHO-00050888-joses",
		"loss_description": "Roof shingles missing and the garage damaged.",
		"loss_date": "2017-09-10T04:00:00.000Z",
		"meta": {},
		"active": true,
		"catastrophe_code": "2017-1744",
		"policy_number": "0000000",
		"policy_effective_date": null,
		"estimated_effort": 72,
		"created_at": "2018-12-10T21:52:10.037Z",
		"updated_at": "2018-12-10T21:52:10.066Z",
		"deleted_at": null,
		"carrier_id": null,
		"incident_id": null,
		"property_id": null,
		"claim_status_id": null,
		"adjuster_id": null,
		"line_of_business_id": null,
		"policy_data": 5,
		"loss_type_pair_id": null,
		"independent_adjuster_id": null,
		"policy_type_id": null,
		"deductible_code_id": null,
		"reserve": {
			"current": {
				"reg_at": "2018-12-10T21:50:31.468+00:00",
				"a_limit": 0,
				"a_value": 0,
				"b_limit": 0,
				"b_value": 0,
				"c_limit": 0,
				"c_value": 0,
				"d_limit": 0,
				"d_value": 0,
				"e_limit": 0,
				"e_value": 0,
				"f_limit": 0,
				"f_value": 0
			},
			"history": []
		},
		"case_id": null
    },
  })

  //console.log({ alice })
}
main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })