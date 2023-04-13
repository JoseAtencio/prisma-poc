-- CreateEnum
CREATE TYPE "enum_Activities_activity_type" AS ENUM ('NOTE', 'ATTACHMENT', 'STATUS_UPDATE', 'CLAIM_UPDATED', 'CHECK_IN', 'CHECK_OUT', 'RECEIVED', 'CLOSED', 'ERROR', 'ASSIGNED_TO', 'COMMUNICATED', 'COVERAGE_A_UPDATE', 'COVERAGE_B_UPDATE', 'COVERAGE_C_UPDATE', 'COVERAGE_D_UPDATE', 'COVERAGE_E_UPDATE', 'COVERAGE_F_UPDATE', 'PHONE_CALL', 'CLAIM_STATUS_UPDATED');

-- CreateEnum
CREATE TYPE "enum_Addresses_type" AS ENUM ('WORK', 'HOME');

-- CreateEnum
CREATE TYPE "enum_Attachments_attachment_type" AS ENUM ('DOC', 'IMAGE', 'VIDEO', 'AUDIO', 'OTHER');

-- CreateEnum
CREATE TYPE "enum_Attachments_status" AS ENUM ('INGESTED', 'PROCESSED', 'TRANSCODED', 'PUBLISHED', 'ERROR', 'UPLOADED', 'NEW');

-- CreateEnum
CREATE TYPE "enum_Contacts_type" AS ENUM ('Insured', 'Additional Insured', 'Family Member', 'Claimant', 'Agent', 'Mortgage', 'Lienholder', 'Public Adjuster', 'Power of Attorney', 'Attorney', 'TPA Representative', 'Umpire', 'Opposing Appraiser', 'Other');

-- CreateEnum
CREATE TYPE "enum_Deliverables_type" AS ENUM ('TaskForm', 'Upload');

-- CreateEnum
CREATE TYPE "enum_Emails_type" AS ENUM ('WORK', 'PERSONAL');

-- CreateEnum
CREATE TYPE "enum_InspQuestions_answer_type" AS ENUM ('SINGLE_CHOICE', 'MULTIPLE_CHOICE', 'SINGLE_TEXT_LINE', 'MULTIPLE_TEXT_LINE');

-- CreateEnum
CREATE TYPE "enum_Inspections_status" AS ENUM ('Draft', 'Published');

-- CreateEnum
CREATE TYPE "enum_Inspections_version" AS ENUM ('Preliminary', 'Interim', 'Final', 'Supplemental');

-- CreateEnum
CREATE TYPE "enum_Phones_type" AS ENUM ('WORK', 'PERSONAL', 'HOME');

-- CreateEnum
CREATE TYPE "enum_UserNotifications_status" AS ENUM ('NEW', 'SEEN', 'OPENED');

-- CreateEnum
CREATE TYPE "enum_Users_role" AS ENUM ('SUPER-USER', 'ADMINISTRATOR', 'MANAGER', 'SUPERVISOR', 'EXAMINER', 'INSPECTOR', 'ADJUSTER', 'TRAINER', 'VOUCHER-USER');

-- CreateEnum
CREATE TYPE "enum_Users_speciality" AS ENUM ('Painters', 'Fencers', 'Landscapers', 'General Contractor', 'Roofer', 'Ladder Assist', 'Electrician', 'HVAC', 'Plumber', 'Temp Repair', 'Board Up Company', 'Water Mitigation', 'Content Restoration', 'Dry Cleaners', 'Cause and Origin', 'Leak Detection', 'Engineer', 'Electronics Technician', 'Attorney', 'DAT (Data Acquisition Technician)', 'DAP (Data Acquisition Pro)', 'DTI (Data Thermal Imaging)', 'ADS (Aerial Data Specialist - Drone)');

-- CreateEnum
CREATE TYPE "enum_Users_status" AS ENUM ('Pending', 'Active', 'Inactive');

-- CreateEnum
CREATE TYPE "enum_VoiceCalls_merge_status" AS ENUM ('QUEUED', 'HOLD', 'IN_PROGRESS', 'RECORDING', 'COMPLETED', 'NOT_PROCESSED');

-- CreateEnum
CREATE TYPE "enum_VoiceCalls_recording_type" AS ENUM ('CALL', 'VOICEMAIL');

-- CreateTable
CREATE TABLE "AreaMedias" (
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "area_id" INTEGER NOT NULL,
    "attachment_id" INTEGER NOT NULL,

    CONSTRAINT "AreaMedias_pkey" PRIMARY KEY ("area_id","attachment_id")
);

-- CreateTable
CREATE TABLE "AreaRegInformations" (
    "answer" TEXT,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "area_id" INTEGER NOT NULL,
    "insp_question_id" INTEGER NOT NULL,

    CONSTRAINT "AreaRegInformations_pkey" PRIMARY KEY ("area_id","insp_question_id")
);

-- CreateTable
CREATE TABLE "Areas" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "has_damage" BOOLEAN NOT NULL DEFAULT false,
    "measurements" JSON[],
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "inspection_id" INTEGER,
    "subject_category_pair_id" INTEGER,

    CONSTRAINT "Areas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AssignmentStatuses" (
    "id" SERIAL NOT NULL,
    "code" VARCHAR(255) NOT NULL,
    "caption" VARCHAR(255) NOT NULL,
    "percentage_of_effort" DECIMAL NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "AssignmentStatuses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AssignmentTeamMembers" (
    "id" SERIAL NOT NULL,
    "meta" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "assignment_id" INTEGER,
    "contact_id" INTEGER,

    CONSTRAINT "AssignmentTeamMembers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AssignmentTypeModifiers" (
    "id" SERIAL NOT NULL,
    "code" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "AssignmentTypeModifiers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AssignmentTypes" (
    "id" SERIAL NOT NULL,
    "code" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "AssignmentTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Assignments" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "process_flow" JSONB,
    "meta" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "case_id" INTEGER,
    "type_id" INTEGER,
    "type_modifier_id" INTEGER,
    "status_id" INTEGER,
    "assigner_organization_id" INTEGER,
    "assigned_organization_id" INTEGER,

    CONSTRAINT "Assignments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Attachments" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "filename" VARCHAR(255) NOT NULL,
    "status" "enum_Attachments_status" NOT NULL,
    "attachment_type" "enum_Attachments_attachment_type" NOT NULL,
    "url" VARCHAR(255),
    "thumbnail" VARCHAR(255),
    "build_guid" VARCHAR(255),
    "meta" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "claim_id" INTEGER,
    "area_id" INTEGER,
    "voucher_id" INTEGER,

    CONSTRAINT "Attachments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BusinessContacts" (
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "business_id" INTEGER NOT NULL,
    "contact_id" INTEGER NOT NULL,

    CONSTRAINT "BusinessContacts_pkey" PRIMARY KEY ("business_id","contact_id")
);

-- CreateTable
CREATE TABLE "Businesses" (
    "id" SERIAL NOT NULL,
    "tags" JSONB,
    "meta" JSONB,
    "name" VARCHAR(255) NOT NULL,
    "legal_name" VARCHAR(255) NOT NULL,
    "alternative_name" VARCHAR(255),
    "sites" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "contact_id" INTEGER,

    CONSTRAINT "Businesses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CarrierAssignmentTypeModifiers" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "seq" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "carrier_assignment_type_id" INTEGER,
    "type_modifier_entity_id" INTEGER,

    CONSTRAINT "CarrierAssignmentTypeModifiers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CarrierAssignmentTypes" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "seq" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "carrier_case_type_id" INTEGER,
    "type_entity_id" INTEGER,

    CONSTRAINT "CarrierAssignmentTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CarrierCaseTypes" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "seq" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "carrier_id" INTEGER,
    "type_entity_id" INTEGER,

    CONSTRAINT "CarrierCaseTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CarrierLineOfBusiness" (
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "carrier_id" INTEGER NOT NULL,
    "line_of_business_id" INTEGER NOT NULL,

    CONSTRAINT "CarrierLineOfBusiness_pkey" PRIMARY KEY ("carrier_id","line_of_business_id")
);

-- CreateTable
CREATE TABLE "CarrierProcessFlowScenarios" (
    "id" SERIAL NOT NULL,
    "effective_at" TIMESTAMPTZ(6) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "active" BOOLEAN NOT NULL,
    "caption" VARCHAR(255),
    "description" TEXT NOT NULL,
    "meta" JSONB,
    "event" JSONB,
    "conditions" JSONB,
    "carrier_flow_id" INTEGER,
    "carrier_lob_id" INTEGER,
    "carrier_case_type_id" INTEGER,
    "carrier_assignment_type_id" INTEGER,
    "carrier_assignment_type_modifier_id" INTEGER,

    CONSTRAINT "CarrierProcessFlowScenarios_pkey_1" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CarrierProcessFlows" (
    "id" SERIAL NOT NULL,
    "effective_at" TIMESTAMPTZ(6) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "active" BOOLEAN NOT NULL,
    "flow_id" INTEGER,
    "carrier_id" INTEGER,
    "facts" JSONB,
    "meta" JSONB,

    CONSTRAINT "CarrierProcessFlows_pkey_1" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CarrierVendorPreferences" (
    "preference_level" INTEGER NOT NULL DEFAULT 0,
    "for_specialities" INTEGER[] DEFAULT ARRAY[]::INTEGER[],
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "carrier_id" INTEGER NOT NULL,
    "vendor_id" INTEGER NOT NULL,

    CONSTRAINT "CarrierVendorPreferences_pkey" PRIMARY KEY ("carrier_id","vendor_id")
);

-- CreateTable
CREATE TABLE "Carriers" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "status" INTEGER NOT NULL,
    "type" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255),
    "short_name" VARCHAR(255),
    "legal_name" VARCHAR(255) NOT NULL,
    "web_url" VARCHAR(255),
    "meta" JSONB,
    "logo" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "contact_id" INTEGER,

    CONSTRAINT "Carriers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CaseTypes" (
    "id" SERIAL NOT NULL,
    "code" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "CaseTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cases" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "carrier_id" INTEGER,
    "carrier_case_type_id" INTEGER,
    "predecesor_case_id" INTEGER,

    CONSTRAINT "Cases_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClaimContacts" (
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "claim_id" INTEGER NOT NULL,
    "contact_id" INTEGER NOT NULL,

    CONSTRAINT "ClaimContacts_pkey" PRIMARY KEY ("claim_id","contact_id")
);

-- CreateTable
CREATE TABLE "ClaimLossTypeModifiers" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "ClaimLossTypeModifiers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClaimLossTypePairs" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "type_id" INTEGER,
    "modifier_id" INTEGER,

    CONSTRAINT "ClaimLossTypePairs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClaimLossTypes" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "active" BOOLEAN NOT NULL DEFAULT true,
    "order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "ClaimLossTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClaimStatuses" (
    "id" SERIAL NOT NULL,
    "code" VARCHAR(255) NOT NULL,
    "caption" VARCHAR(255) NOT NULL,
    "percentage_of_effort" DECIMAL NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "ClaimStatuses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Claims" (
    "id" SERIAL NOT NULL,
    "carrier_claim_number" VARCHAR(255) NOT NULL,
    "loss_description" TEXT NOT NULL,
    "loss_date" TIMESTAMPTZ(6) NOT NULL,
    "meta" JSONB,
    "active" BOOLEAN NOT NULL,
    "catastrophe_code" VARCHAR(255),
    "policy_number" VARCHAR(255) NOT NULL,
    "policy_effective_date" TIMESTAMPTZ(6),
    "estimated_effort" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "carrier_id" INTEGER,
    "incident_id" INTEGER,
    "property_id" INTEGER,
    "claim_status_id" INTEGER,
    "adjuster_id" INTEGER,
    "line_of_business_id" INTEGER,
    "policy_data" JSONB,
    "loss_type_pair_id" INTEGER,
    "independent_adjuster_id" INTEGER,
    "policy_type_id" INTEGER,
    "deductible_code_id" INTEGER,
    "reserve" JSONB,
    "case_id" INTEGER,

    CONSTRAINT "Claims_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Contacts" (
    "id" SERIAL NOT NULL,
    "description" VARCHAR(255),
    "insured" BOOLEAN DEFAULT false,
    "primary" BOOLEAN DEFAULT false,
    "contact_points" JSONB,
    "meta" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "full_name" VARCHAR(255),
    "user_id" INTEGER,
    "type" "enum_Contacts_type" NOT NULL DEFAULT 'Other',

    CONSTRAINT "Contacts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ConversationContacts" (
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "conversation_id" INTEGER NOT NULL,
    "contact_id" INTEGER NOT NULL,

    CONSTRAINT "ConversationContacts_pkey" PRIMARY KEY ("conversation_id","contact_id")
);

-- CreateTable
CREATE TABLE "Conversations" (
    "id" SERIAL NOT NULL,
    "phone_number" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "claim_id" INTEGER,
    "is_external" BOOLEAN DEFAULT false,
    "owner_contact_id" INTEGER,

    CONSTRAINT "Conversations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DeductibleCodes" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "caption" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "line_of_business_id" INTEGER,

    CONSTRAINT "DeductibleCodes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Deliverables" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL,
    "type" "enum_Deliverables_type" NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "caption" VARCHAR(255) NOT NULL,
    "effective_at" TIMESTAMPTZ(6) NOT NULL,
    "render_def" JSONB,
    "data_def" JSONB,
    "resolution_def" JSONB,
    "meta" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "Deliverables_pkey1" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Emails" (
    "id" SERIAL NOT NULL,
    "caption" VARCHAR(255),
    "type" "enum_Emails_type" NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "primary" BOOLEAN NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "contact_id" INTEGER,

    CONSTRAINT "Emails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FnolRuns" (
    "id" SERIAL NOT NULL,
    "phone_number" VARCHAR(255) NOT NULL,
    "completed" BOOLEAN NOT NULL,
    "info" JSONB,
    "annotations" TEXT,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "FnolRuns_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Imports" (
    "id" SERIAL NOT NULL,
    "carrier_claim_number" VARCHAR(255) NOT NULL,
    "active" BOOLEAN NOT NULL,
    "status" VARCHAR(255),
    "last_msg" VARCHAR(255),
    "txs" VARCHAR(255),
    "original_data" JSONB,
    "cached_data" JSONB,
    "claim_id" INTEGER,
    "carrier_id" INTEGER,
    "history" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "Imports_pkey" PRIMARY KEY ("id","carrier_claim_number")
);

-- CreateTable
CREATE TABLE "Incidents" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "status" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "Incidents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InspQuestionGroups" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "InspQuestionGroups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InspQuestions" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "question" VARCHAR(255) NOT NULL,
    "is_required" BOOLEAN NOT NULL DEFAULT true,
    "answer_type" "enum_InspQuestions_answer_type" NOT NULL,
    "answer_options" JSONB,
    "default_answer" JSONB,
    "answer_assertion" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "question_group_id" INTEGER,

    CONSTRAINT "InspQuestions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InspQuestionsLookups" (
    "id" SERIAL NOT NULL,
    "by_catastrophe_flag" BOOLEAN,
    "is_optional" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "insp_question_group_id" INTEGER,
    "by_carrier_ref" INTEGER,
    "by_line_of_business_ref" INTEGER,
    "by_claim_loss_type_ref" INTEGER,
    "by_claim_loss_modifier_ref" INTEGER,
    "by_insp_subject_ref" INTEGER,
    "by_insp_sub_category_ref" INTEGER,

    CONSTRAINT "InspQuestionsLookups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InspSubjCategPairs" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "subject_id" INTEGER,
    "sub_category_id" INTEGER,

    CONSTRAINT "InspSubjCategPairs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InspSubjCategories" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "InspSubjCategories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InspSubjects" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "may_have_measurements" BOOLEAN NOT NULL DEFAULT true,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "InspSubjects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InspectionTypes" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "active" BOOLEAN NOT NULL DEFAULT true,
    "order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "InspectionTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Inspections" (
    "id" SERIAL NOT NULL,
    "version" "enum_Inspections_version" NOT NULL,
    "status" "enum_Inspections_status" NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "claim_id" INTEGER,
    "type_id" INTEGER,
    "author_user_id" INTEGER,

    CONSTRAINT "Inspections_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Languages" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "caption" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "Languages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LineOfBusinesses" (
    "id" SERIAL NOT NULL,
    "caption" VARCHAR(255) NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "LineOfBusinesses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LobCoverages" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "code" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "limit_name" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "line_of_business_id" INTEGER,

    CONSTRAINT "LobCoverages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Messages" (
    "id" SERIAL NOT NULL,
    "sid" VARCHAR(255) NOT NULL,
    "phone_number" VARCHAR(255) NOT NULL,
    "bulk_id" UUID,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "conversation_id" INTEGER,
    "owner_contact_id" INTEGER,
    "meta" JSONB,

    CONSTRAINT "Messages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Notes" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "sticky" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "claim_id" INTEGER,
    "voice_call_id" INTEGER,
    "meta" JSONB,

    CONSTRAINT "Notes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Permissions" (
    "id" SERIAL NOT NULL,
    "operation_path" VARCHAR(255) NOT NULL,
    "allowed_roles" JSONB,
    "context" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "Permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PermissionsContexts" (
    "id" SERIAL NOT NULL,
    "context" VARCHAR(255) NOT NULL,
    "conditions" VARCHAR(255)[] DEFAULT (ARRAY[]::character varying[])::character varying(255)[],
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "PermissionsContexts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Phones" (
    "id" SERIAL NOT NULL,
    "type" "enum_Phones_type",
    "sms_capable" BOOLEAN NOT NULL DEFAULT false,
    "country_code" VARCHAR(255) NOT NULL,
    "phone_number" VARCHAR(255) NOT NULL,
    "ext" INTEGER,
    "vanity_number" VARCHAR(255),
    "caption" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "contact_id" INTEGER,
    "meta" JSONB,

    CONSTRAINT "Phones_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PolicyTypes" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "caption" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "reserve_template" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "line_of_business_id" INTEGER,

    CONSTRAINT "PolicyTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProcessFlows" (
    "id" SERIAL NOT NULL,
    "caption" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "ProcessFlows_pkey_1" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Properties" (
    "id" SERIAL NOT NULL,
    "type" VARCHAR(255),
    "description" VARCHAR(255),
    "meta" JSONB,
    "contact_points" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "address_id" INTEGER,
    "phone_id" INTEGER,

    CONSTRAINT "Properties_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SequelizeMeta" (
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY ("name")
);

-- CreateTable
CREATE TABLE "Services" (
    "id" SERIAL NOT NULL,
    "caption" VARCHAR(255) NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "Services_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Specialities" (
    "id" SERIAL NOT NULL,
    "caption" VARCHAR(255) NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "Specialities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Stages" (
    "id" SERIAL NOT NULL,
    "catastrophic" BOOLEAN,
    "caption" VARCHAR(255) NOT NULL,
    "seq" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "carrier_id" INTEGER,
    "line_of_business_id" INTEGER,
    "loss_type_pair_id" INTEGER,
    "percentage_of_effort" DECIMAL DEFAULT 0,

    CONSTRAINT "Stages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SubjectDefs" (
    "id" SERIAL NOT NULL,
    "def" JSONB,
    "meta" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "SubjectDefs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SystemReports" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "url" VARCHAR(255) NOT NULL,
    "meta" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "SystemReports_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TMP_layout_s" (
    "id" SERIAL NOT NULL,
    "merge_id" INTEGER,
    "group_id" INTEGER,
    "meta" JSONB,

    CONSTRAINT "TMP_layout_s_pkey_1" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TMP_layout_st" (
    "id" SERIAL NOT NULL,
    "merge_id" INTEGER,
    "group_id" INTEGER,
    "meta" JSONB,

    CONSTRAINT "TMP_layout_st_pkey_1" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TMP_stages" (
    "id" SERIAL NOT NULL,
    "merge_id" INTEGER,
    "group_id" INTEGER,
    "meta" JSONB,

    CONSTRAINT "TMP_stages_pkey_1" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TMP_tasks" (
    "id" SERIAL NOT NULL,
    "merge_id" INTEGER,
    "group_id" INTEGER,
    "meta" JSONB,

    CONSTRAINT "TMP_tasks_pkey_1" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaskActions" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "TaskActions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaskDeliverables" (
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deliverable_id" INTEGER NOT NULL,
    "task_id" INTEGER NOT NULL,

    CONSTRAINT "TaskDeliverables_pkey" PRIMARY KEY ("deliverable_id","task_id")
);

-- CreateTable
CREATE TABLE "TaskStatusTransitions" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "meta" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "initial_status_id" INTEGER,
    "on_action_id" INTEGER,
    "next_status_id" INTEGER,
    "seq" INTEGER DEFAULT 0,

    CONSTRAINT "TaskStatusTransitions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaskStatuses" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "TaskStatuses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tasks" (
    "id" SERIAL NOT NULL,
    "caption" VARCHAR(255) NOT NULL,
    "coverage" VARCHAR(255)[],
    "assignable" BOOLEAN NOT NULL,
    "seq" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "stage_id" INTEGER,
    "hasWorkflow" VARCHAR(255),
    "type" VARCHAR[],
    "percentage_of_effort" DECIMAL DEFAULT 0,

    CONSTRAINT "Tasks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserCarriers" (
    "active" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "carrier_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "UserCarriers_pkey" PRIMARY KEY ("carrier_id","user_id")
);

-- CreateTable
CREATE TABLE "UserFcmTokens" (
    "id" SERIAL NOT NULL,
    "token" VARCHAR(255) NOT NULL,
    "token_info" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "user_id" INTEGER,

    CONSTRAINT "UserFcmTokens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserLanguages" (
    "primary" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "language_id" INTEGER NOT NULL,

    CONSTRAINT "UserLanguages_pkey" PRIMARY KEY ("user_id","language_id")
);

-- CreateTable
CREATE TABLE "UserServiceAreas" (
    "for_specialities" INTEGER[] DEFAULT ARRAY[]::INTEGER[],
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "address_id" INTEGER NOT NULL,

    CONSTRAINT "UserServiceAreas_pkey" PRIMARY KEY ("user_id","address_id")
);

-- CreateTable
CREATE TABLE "UserSpecialityServices" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "service_id" INTEGER,
    "speciality_id" INTEGER,
    "user_id" INTEGER,

    CONSTRAINT "UserSpecialityServices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserVendors" (
    "active" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "vendor_id" INTEGER NOT NULL,

    CONSTRAINT "UserVendors_pkey" PRIMARY KEY ("user_id","vendor_id")
);

-- CreateTable
CREATE TABLE "Users" (
    "id" SERIAL NOT NULL,
    "full_name" VARCHAR(255),
    "username" VARCHAR(255),
    "email" VARCHAR(255) NOT NULL,
    "role" "enum_Users_role" NOT NULL,
    "speciality" "enum_Users_speciality",
    "status" "enum_Users_status" NOT NULL DEFAULT 'Pending',
    "avatar" VARCHAR(255),
    "activation_code" UUID,
    "is_tc" BOOLEAN DEFAULT false,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VendorCarrier" (
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "carrier_id" INTEGER NOT NULL,
    "vendor_id" INTEGER NOT NULL,

    CONSTRAINT "VendorCarrier_pkey" PRIMARY KEY ("carrier_id","vendor_id")
);

-- CreateTable
CREATE TABLE "VendorServiceAreas" (
    "for_specialities" INTEGER[] DEFAULT ARRAY[]::INTEGER[],
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "vendor_id" INTEGER NOT NULL,
    "address_id" INTEGER NOT NULL,

    CONSTRAINT "VendorServiceAreas_pkey" PRIMARY KEY ("vendor_id","address_id")
);

-- CreateTable
CREATE TABLE "VendorSpecialty" (
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "speciality_id" INTEGER NOT NULL,
    "vendor_id" INTEGER NOT NULL,
    "costs" JSONB,
    "meta" JSONB,

    CONSTRAINT "VendorSpecialty_pkey" PRIMARY KEY ("speciality_id","vendor_id")
);

-- CreateTable
CREATE TABLE "VendorUserPreferences" (
    "preference_level" INTEGER NOT NULL DEFAULT 0,
    "for_specialities" INTEGER[] DEFAULT ARRAY[]::INTEGER[],
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "vendor_id" INTEGER NOT NULL,

    CONSTRAINT "VendorUserPreferences_pkey" PRIMARY KEY ("user_id","vendor_id")
);

-- CreateTable
CREATE TABLE "Vendors" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "name" VARCHAR(255),
    "legal_name" VARCHAR(255) NOT NULL,
    "web_url" VARCHAR(255),
    "meta" JSONB,
    "logo" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "contact_id" INTEGER,

    CONSTRAINT "Vendors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VideoRooms" (
    "id" SERIAL NOT NULL,
    "sid" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "status" VARCHAR(255) NOT NULL,
    "duration" INTEGER,
    "end_time" TIMESTAMPTZ(6),
    "composition_sid" VARCHAR(255),
    "composition_url" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "conversation_id" INTEGER,
    "owner_contact_id" INTEGER,

    CONSTRAINT "VideoRooms_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VoiceCalls" (
    "id" SERIAL NOT NULL,
    "sid" VARCHAR(255) NOT NULL,
    "from" VARCHAR(255) NOT NULL,
    "to" VARCHAR(255) NOT NULL,
    "direction" VARCHAR(255) NOT NULL,
    "status" VARCHAR(255) NOT NULL,
    "duration" INTEGER,
    "merge_status" "enum_VoiceCalls_merge_status" NOT NULL,
    "status_updated_at" TIMESTAMPTZ(6) NOT NULL,
    "recording_type" "enum_VoiceCalls_recording_type",
    "recording_url" VARCHAR(255),
    "recording_sid" VARCHAR(255),
    "recording_duration" INTEGER,
    "api_version" VARCHAR(255),
    "caller_name" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "conversation_id" INTEGER,
    "attendant_contact_id" INTEGER,
    "meta" JSONB,

    CONSTRAINT "VoiceCalls_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VoucherTypes" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "caption" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "order" INTEGER NOT NULL DEFAULT 0,
    "proc_statuses" VARCHAR(255)[] DEFAULT (ARRAY[]::character varying[])::character varying(255)[],
    "order_attributes" JSONB,
    "redemption_attributes" JSONB,
    "meta" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "VoucherTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Vouchers" (
    "id" SERIAL NOT NULL,
    "redemption_code" VARCHAR(255) NOT NULL,
    "cycle_status" VARCHAR(255) NOT NULL,
    "cycle_dates" JSONB,
    "claim_info" JSONB,
    "order_info" JSONB,
    "redemption_info" JSONB,
    "activities" JSONB,
    "meta" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "type_id" INTEGER,
    "claim_id" INTEGER,

    CONSTRAINT "Vouchers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkflowPublications" (
    "id" SERIAL NOT NULL,
    "data" JSONB,
    "meta" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "task_work_id" INTEGER,

    CONSTRAINT "WorkflowPublications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Works" (
    "id" SERIAL NOT NULL,
    "checked" BOOLEAN,
    "note" TEXT,
    "active" BOOLEAN,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),
    "claim_id" INTEGER,
    "task_id" INTEGER,
    "assignment_user_id" INTEGER,
    "status_id" INTEGER,
    "scheduled_date" TIMESTAMPTZ(6),
    "last_known_location" JSONB,
    "meta" JSONB,
    "assignment_workflow_pub_id" INTEGER,
    "assignment_id" INTEGER,
    "team_member_id" INTEGER,

    CONSTRAINT "Works_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "all_open_claims" (
    "loc_id" VARCHAR(50),
    "desk_adjuster" VARCHAR(255),
    "inspector" VARCHAR(255),
    "insured" VARCHAR(255),
    "insured_phone" VARCHAR(50),
    "carrier_claim_number" VARCHAR(50),
    "policy_number" VARCHAR(50),
    "risk_address_1" VARCHAR(255),
    "risk_city" VARCHAR(255),
    "risk_zip" VARCHAR(50),
    "ni_contacted" VARCHAR(50),
    "ni_contact_next_action" VARCHAR(50),
    "ni_contacted_date" VARCHAR(50),
    "inspection_scheduled" VARCHAR(50),
    "inspection_scheduled_next_action" VARCHAR(50),
    "inspection_scheduled_date" VARCHAR(50),
    "inspection_uploaded" VARCHAR(50),
    "inspection_notes" TEXT,
    "ni_contacted_note" TEXT,
    "id" SERIAL NOT NULL,

    CONSTRAINT "all_open_claims_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "coffee" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR NOT NULL,
    "description" VARCHAR,
    "brand" VARCHAR NOT NULL,
    "recommendations" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "PK_4d27239ee0b99a491ad806aec46" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "coffee_flavors_flavor" (
    "coffeeId" INTEGER NOT NULL,
    "flavorId" INTEGER NOT NULL,

    CONSTRAINT "PK_64cde86968c8b440e3c63626e80" PRIMARY KEY ("coffeeId","flavorId")
);

-- CreateTable
CREATE TABLE "event" (
    "id" SERIAL NOT NULL,
    "type" VARCHAR NOT NULL,
    "name" VARCHAR NOT NULL,
    "payload" JSON NOT NULL,

    CONSTRAINT "PK_30c2f3bbaf6d34a55f8ae6e4614" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "flavor" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR NOT NULL,

    CONSTRAINT "PK_934fe79b3d8131395c29a040ee5" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "AssignmentTypeModifiers_code_key" ON "AssignmentTypeModifiers"("code");

-- CreateIndex
CREATE UNIQUE INDEX "AssignmentTypeModifiers_name_key" ON "AssignmentTypeModifiers"("name");

-- CreateIndex
CREATE UNIQUE INDEX "AssignmentTypes_code_key" ON "AssignmentTypes"("code");

-- CreateIndex
CREATE UNIQUE INDEX "AssignmentTypes_name_key" ON "AssignmentTypes"("name");

-- CreateIndex
CREATE UNIQUE INDEX "CarrierAssignmentTypeModifiers_unique_pair" ON "CarrierAssignmentTypeModifiers"("carrier_assignment_type_id", "type_modifier_entity_id");

-- CreateIndex
CREATE UNIQUE INDEX "CarrierAssignmentTypes_unique_pair" ON "CarrierAssignmentTypes"("carrier_case_type_id", "type_entity_id");

-- CreateIndex
CREATE UNIQUE INDEX "CarrierCaseTypes_unique_pair" ON "CarrierCaseTypes"("carrier_id", "type_entity_id");

-- CreateIndex
CREATE UNIQUE INDEX "CaseTypes_code_key" ON "CaseTypes"("code");

-- CreateIndex
CREATE UNIQUE INDEX "CaseTypes_name_key" ON "CaseTypes"("name");

-- CreateIndex
CREATE UNIQUE INDEX "ClaimContacts_contact_id" ON "ClaimContacts"("contact_id");

-- CreateIndex
CREATE UNIQUE INDEX "ClaimLossTypeModifiers_title_key" ON "ClaimLossTypeModifiers"("title");

-- CreateIndex
CREATE UNIQUE INDEX "ClaimLossTypePairs_unique_pair" ON "ClaimLossTypePairs"("type_id", "modifier_id");

-- CreateIndex
CREATE UNIQUE INDEX "ClaimLossTypes_title_key" ON "ClaimLossTypes"("title");

-- CreateIndex
CREATE UNIQUE INDEX "Imports_carrier_claim_number_key" ON "Imports"("carrier_claim_number");

-- CreateIndex
CREATE UNIQUE INDEX "InspQuestionsLookups_unique_refers" ON "InspQuestionsLookups"("by_carrier_ref", "by_catastrophe_flag", "by_line_of_business_ref", "by_claim_loss_type_ref", "by_claim_loss_modifier_ref", "by_insp_subject_ref", "by_insp_sub_category_ref", "insp_question_group_id");

-- CreateIndex
CREATE UNIQUE INDEX "InspSubjCategPairs_unique_pair" ON "InspSubjCategPairs"("subject_id", "sub_category_id");

-- CreateIndex
CREATE UNIQUE INDEX "InspSubjCategories_title_key" ON "InspSubjCategories"("title");

-- CreateIndex
CREATE UNIQUE INDEX "InspSubjects_title_key" ON "InspSubjects"("title");

-- CreateIndex
CREATE UNIQUE INDEX "InspectionTypes_title_key" ON "InspectionTypes"("title");

-- CreateIndex
CREATE UNIQUE INDEX "PolicyTypes_caption_key" ON "PolicyTypes"("caption");

-- CreateIndex
CREATE UNIQUE INDEX "VoiceCalls_sid_key" ON "VoiceCalls"("sid");

-- CreateIndex
CREATE UNIQUE INDEX "VoucherTypes_caption_key" ON "VoucherTypes"("caption");

-- CreateIndex
CREATE INDEX "IDX_25642975c6f620d570c635f418" ON "coffee_flavors_flavor"("flavorId");

-- CreateIndex
CREATE INDEX "IDX_9cb98a3799afc95cf71fdb1c4f" ON "coffee_flavors_flavor"("coffeeId");

-- CreateIndex
CREATE INDEX "IDX_b535fbe8ec6d832dde22065ebd" ON "event"("name");

-- AddForeignKey
ALTER TABLE "AreaMedias" ADD CONSTRAINT "AreaMedias_area_id_fkey" FOREIGN KEY ("area_id") REFERENCES "Areas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AreaMedias" ADD CONSTRAINT "AreaMedias_attachment_id_fkey" FOREIGN KEY ("attachment_id") REFERENCES "Attachments"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AreaRegInformations" ADD CONSTRAINT "AreaRegInformations_area_id_fkey" FOREIGN KEY ("area_id") REFERENCES "Areas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AreaRegInformations" ADD CONSTRAINT "AreaRegInformations_insp_question_id_fkey" FOREIGN KEY ("insp_question_id") REFERENCES "InspQuestions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Areas" ADD CONSTRAINT "Areas_inspection_id_fkey" FOREIGN KEY ("inspection_id") REFERENCES "Inspections"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Areas" ADD CONSTRAINT "Areas_subject_category_pair_id_fkey" FOREIGN KEY ("subject_category_pair_id") REFERENCES "InspSubjCategPairs"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AssignmentTeamMembers" ADD CONSTRAINT "AssignmentTeamMembers_assignment_id_fkey" FOREIGN KEY ("assignment_id") REFERENCES "Assignments"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AssignmentTeamMembers" ADD CONSTRAINT "AssignmentTeamMembers_contact_id_fkey" FOREIGN KEY ("contact_id") REFERENCES "Contacts"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Assignments" ADD CONSTRAINT "Assignments_assigned_organization_id_fkey" FOREIGN KEY ("assigned_organization_id") REFERENCES "Contacts"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Assignments" ADD CONSTRAINT "Assignments_assigner_organization_id_fkey" FOREIGN KEY ("assigner_organization_id") REFERENCES "Contacts"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Assignments" ADD CONSTRAINT "Assignments_case_id_fkey" FOREIGN KEY ("case_id") REFERENCES "Cases"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Assignments" ADD CONSTRAINT "Assignments_status_id_fkey" FOREIGN KEY ("status_id") REFERENCES "AssignmentStatuses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Assignments" ADD CONSTRAINT "Assignments_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "CarrierAssignmentTypes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Assignments" ADD CONSTRAINT "Assignments_type_modifier_id_fkey" FOREIGN KEY ("type_modifier_id") REFERENCES "CarrierAssignmentTypeModifiers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Attachments" ADD CONSTRAINT "Attachments_claim_id_fkey" FOREIGN KEY ("claim_id") REFERENCES "Claims"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Attachments" ADD CONSTRAINT "Attachments_voucher_id_fkey" FOREIGN KEY ("voucher_id") REFERENCES "Vouchers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BusinessContacts" ADD CONSTRAINT "BusinessContacts_business_id_fkey" FOREIGN KEY ("business_id") REFERENCES "Businesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BusinessContacts" ADD CONSTRAINT "BusinessContacts_contact_id_fkey" FOREIGN KEY ("contact_id") REFERENCES "Contacts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Businesses" ADD CONSTRAINT "Businesses_contact_id_fkey" FOREIGN KEY ("contact_id") REFERENCES "Contacts"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierAssignmentTypeModifiers" ADD CONSTRAINT "CarrierAssignmentTypeModifiers_assignment_type_modifier_id_fkey" FOREIGN KEY ("type_modifier_entity_id") REFERENCES "AssignmentTypeModifiers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierAssignmentTypeModifiers" ADD CONSTRAINT "CarrierAssignmentTypeModifiers_carrier_assignment_type_id_fkey" FOREIGN KEY ("carrier_assignment_type_id") REFERENCES "CarrierAssignmentTypes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierAssignmentTypes" ADD CONSTRAINT "CarrierAssignmentTypes_assignment_type_id_fkey" FOREIGN KEY ("type_entity_id") REFERENCES "AssignmentTypes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierAssignmentTypes" ADD CONSTRAINT "CarrierAssignmentTypes_carrier_case_type_id_fkey" FOREIGN KEY ("carrier_case_type_id") REFERENCES "CarrierCaseTypes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierCaseTypes" ADD CONSTRAINT "CarrierCaseTypes_carrier_id_fkey" FOREIGN KEY ("carrier_id") REFERENCES "Carriers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierCaseTypes" ADD CONSTRAINT "CarrierCaseTypes_case_type_id_fkey" FOREIGN KEY ("type_entity_id") REFERENCES "CaseTypes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierLineOfBusiness" ADD CONSTRAINT "CarrierLineOfBusiness_carrier_id_fkey" FOREIGN KEY ("carrier_id") REFERENCES "Carriers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierLineOfBusiness" ADD CONSTRAINT "CarrierLineOfBusiness_line_of_business_id_fkey" FOREIGN KEY ("line_of_business_id") REFERENCES "LineOfBusinesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierProcessFlowScenarios" ADD CONSTRAINT "CarrierProcessFlowScenarios_carrier_assignment_type_id_fkey" FOREIGN KEY ("carrier_assignment_type_id") REFERENCES "CarrierAssignmentTypes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierProcessFlowScenarios" ADD CONSTRAINT "CarrierProcessFlowScenarios_carrier_assignment_type_modifier_id" FOREIGN KEY ("carrier_assignment_type_modifier_id") REFERENCES "CarrierAssignmentTypeModifiers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierProcessFlowScenarios" ADD CONSTRAINT "CarrierProcessFlowScenarios_carrier_case_type_id_fkey" FOREIGN KEY ("carrier_case_type_id") REFERENCES "CarrierCaseTypes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierProcessFlowScenarios" ADD CONSTRAINT "CarrierProcessFlowScenarios_carrier_flow_id_fkey" FOREIGN KEY ("carrier_flow_id") REFERENCES "CarrierProcessFlows"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierProcessFlowScenarios" ADD CONSTRAINT "CarrierProcessFlowScenarios_carrier_lob_id_fkey" FOREIGN KEY ("carrier_lob_id") REFERENCES "LineOfBusinesses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierProcessFlows" ADD CONSTRAINT "CarrierProcessFlows_carrier_id_fkey" FOREIGN KEY ("carrier_id") REFERENCES "Carriers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierProcessFlows" ADD CONSTRAINT "CarrierProcessFlows_flow_id_fkey" FOREIGN KEY ("flow_id") REFERENCES "ProcessFlows"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierVendorPreferences" ADD CONSTRAINT "CarrierVendorPreferences_carrier_id_fkey" FOREIGN KEY ("carrier_id") REFERENCES "Carriers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierVendorPreferences" ADD CONSTRAINT "CarrierVendorPreferences_vendor_id_fkey" FOREIGN KEY ("vendor_id") REFERENCES "Vendors"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Carriers" ADD CONSTRAINT "Carriers_contact_id_fkey" FOREIGN KEY ("contact_id") REFERENCES "Contacts"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cases" ADD CONSTRAINT "Cases_carrier_case_type_id_fkey" FOREIGN KEY ("carrier_case_type_id") REFERENCES "CarrierCaseTypes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cases" ADD CONSTRAINT "Cases_carrier_id_fkey" FOREIGN KEY ("carrier_id") REFERENCES "Carriers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cases" ADD CONSTRAINT "Cases_predecesor_case_id_fkey" FOREIGN KEY ("predecesor_case_id") REFERENCES "Cases"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClaimContacts" ADD CONSTRAINT "ClaimContacts_claim_id_fkey" FOREIGN KEY ("claim_id") REFERENCES "Claims"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClaimContacts" ADD CONSTRAINT "ClaimContacts_contact_id_fkey" FOREIGN KEY ("contact_id") REFERENCES "Contacts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClaimLossTypePairs" ADD CONSTRAINT "ClaimLossTypePairs_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "ClaimLossTypes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Claims" ADD CONSTRAINT "Claims_adjuster_id_fkey" FOREIGN KEY ("adjuster_id") REFERENCES "Users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Claims" ADD CONSTRAINT "Claims_carrier_id_fkey" FOREIGN KEY ("carrier_id") REFERENCES "Carriers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Claims" ADD CONSTRAINT "Claims_case_id_fkey" FOREIGN KEY ("case_id") REFERENCES "Cases"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Claims" ADD CONSTRAINT "Claims_claim_status_id_fkey" FOREIGN KEY ("claim_status_id") REFERENCES "ClaimStatuses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Claims" ADD CONSTRAINT "Claims_deductible_code_id_fkey" FOREIGN KEY ("deductible_code_id") REFERENCES "DeductibleCodes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Claims" ADD CONSTRAINT "Claims_incident_id_fkey" FOREIGN KEY ("incident_id") REFERENCES "Incidents"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Claims" ADD CONSTRAINT "Claims_independent_adjuster_id_fkey" FOREIGN KEY ("independent_adjuster_id") REFERENCES "Users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Claims" ADD CONSTRAINT "Claims_line_of_business_id_fkey" FOREIGN KEY ("line_of_business_id") REFERENCES "LineOfBusinesses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Claims" ADD CONSTRAINT "Claims_loss_type_pair_id_fkey" FOREIGN KEY ("loss_type_pair_id") REFERENCES "ClaimLossTypePairs"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Claims" ADD CONSTRAINT "Claims_policy_type_id_fkey" FOREIGN KEY ("policy_type_id") REFERENCES "PolicyTypes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Claims" ADD CONSTRAINT "Claims_property_id_fkey" FOREIGN KEY ("property_id") REFERENCES "Properties"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contacts" ADD CONSTRAINT "Contacts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ConversationContacts" ADD CONSTRAINT "ConversationContacts_contact_id_fkey" FOREIGN KEY ("contact_id") REFERENCES "Contacts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ConversationContacts" ADD CONSTRAINT "ConversationContacts_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "Conversations"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Conversations" ADD CONSTRAINT "Conversations_claim_id_fkey" FOREIGN KEY ("claim_id") REFERENCES "Claims"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Conversations" ADD CONSTRAINT "Conversations_owner_contact_id_fkey" FOREIGN KEY ("owner_contact_id") REFERENCES "Contacts"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeductibleCodes" ADD CONSTRAINT "DeductibleCodes_line_of_business_id_fkey" FOREIGN KEY ("line_of_business_id") REFERENCES "LineOfBusinesses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Emails" ADD CONSTRAINT "Emails_contact_id_fkey" FOREIGN KEY ("contact_id") REFERENCES "Contacts"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InspQuestions" ADD CONSTRAINT "InspQuestions_question_group_id_fkey" FOREIGN KEY ("question_group_id") REFERENCES "InspQuestionGroups"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InspQuestionsLookups" ADD CONSTRAINT "InspQuestionsLookups_by_carrier_ref_fkey" FOREIGN KEY ("by_carrier_ref") REFERENCES "Carriers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InspQuestionsLookups" ADD CONSTRAINT "InspQuestionsLookups_by_claim_loss_modifier_ref_fkey" FOREIGN KEY ("by_claim_loss_modifier_ref") REFERENCES "ClaimLossTypeModifiers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InspQuestionsLookups" ADD CONSTRAINT "InspQuestionsLookups_by_claim_loss_type_ref_fkey" FOREIGN KEY ("by_claim_loss_type_ref") REFERENCES "ClaimLossTypes"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InspQuestionsLookups" ADD CONSTRAINT "InspQuestionsLookups_by_insp_sub_category_ref_fkey" FOREIGN KEY ("by_insp_sub_category_ref") REFERENCES "InspSubjCategories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InspQuestionsLookups" ADD CONSTRAINT "InspQuestionsLookups_by_insp_subject_ref_fkey" FOREIGN KEY ("by_insp_subject_ref") REFERENCES "InspSubjects"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InspQuestionsLookups" ADD CONSTRAINT "InspQuestionsLookups_by_line_of_business_ref_fkey" FOREIGN KEY ("by_line_of_business_ref") REFERENCES "LineOfBusinesses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InspQuestionsLookups" ADD CONSTRAINT "InspQuestionsLookups_insp_question_group_id_fkey" FOREIGN KEY ("insp_question_group_id") REFERENCES "InspQuestionGroups"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InspSubjCategPairs" ADD CONSTRAINT "InspSubjCategPairs_sub_category_id_fkey" FOREIGN KEY ("sub_category_id") REFERENCES "InspSubjCategories"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InspSubjCategPairs" ADD CONSTRAINT "InspSubjCategPairs_subject_id_fkey" FOREIGN KEY ("subject_id") REFERENCES "InspSubjects"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inspections" ADD CONSTRAINT "Inspections_author_user_id_fkey" FOREIGN KEY ("author_user_id") REFERENCES "Users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inspections" ADD CONSTRAINT "Inspections_claim_id_fkey" FOREIGN KEY ("claim_id") REFERENCES "Claims"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inspections" ADD CONSTRAINT "Inspections_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "InspectionTypes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LobCoverages" ADD CONSTRAINT "LobCoverages_line_of_business_id_fkey" FOREIGN KEY ("line_of_business_id") REFERENCES "LineOfBusinesses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Messages" ADD CONSTRAINT "Messages_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "Conversations"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Messages" ADD CONSTRAINT "Messages_owner_contact_id_fkey" FOREIGN KEY ("owner_contact_id") REFERENCES "Contacts"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notes" ADD CONSTRAINT "Notes_claim_id_fkey" FOREIGN KEY ("claim_id") REFERENCES "Claims"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notes" ADD CONSTRAINT "Notes_voice_call_id_fkey" FOREIGN KEY ("voice_call_id") REFERENCES "VoiceCalls"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Phones" ADD CONSTRAINT "Phones_contact_id_fkey" FOREIGN KEY ("contact_id") REFERENCES "Contacts"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PolicyTypes" ADD CONSTRAINT "PolicyTypes_line_of_business_id_fkey" FOREIGN KEY ("line_of_business_id") REFERENCES "LineOfBusinesses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Properties" ADD CONSTRAINT "Properties_phone_id_fkey" FOREIGN KEY ("phone_id") REFERENCES "Phones"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Stages" ADD CONSTRAINT "Stages_carrier_id_fkey" FOREIGN KEY ("carrier_id") REFERENCES "Carriers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Stages" ADD CONSTRAINT "Stages_line_of_business_id_fkey" FOREIGN KEY ("line_of_business_id") REFERENCES "LineOfBusinesses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Stages" ADD CONSTRAINT "Stages_loss_type_pair_id_fkey" FOREIGN KEY ("loss_type_pair_id") REFERENCES "ClaimLossTypePairs"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TaskDeliverables" ADD CONSTRAINT "TaskDeliverables_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "Tasks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TaskStatusTransitions" ADD CONSTRAINT "TaskStatusTransitions_initial_status_id_fkey" FOREIGN KEY ("initial_status_id") REFERENCES "TaskStatuses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TaskStatusTransitions" ADD CONSTRAINT "TaskStatusTransitions_next_status_id_fkey" FOREIGN KEY ("next_status_id") REFERENCES "TaskStatuses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TaskStatusTransitions" ADD CONSTRAINT "TaskStatusTransitions_on_action_id_fkey" FOREIGN KEY ("on_action_id") REFERENCES "TaskActions"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tasks" ADD CONSTRAINT "Tasks_stage_id_fkey" FOREIGN KEY ("stage_id") REFERENCES "Stages"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserCarriers" ADD CONSTRAINT "UserCarriers_carrier_id_fkey" FOREIGN KEY ("carrier_id") REFERENCES "Carriers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserCarriers" ADD CONSTRAINT "UserCarriers_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserFcmTokens" ADD CONSTRAINT "UserFcmTokens_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserLanguages" ADD CONSTRAINT "UserLanguages_language_id_fkey" FOREIGN KEY ("language_id") REFERENCES "Languages"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserLanguages" ADD CONSTRAINT "UserLanguages_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserServiceAreas" ADD CONSTRAINT "UserServiceAreas_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSpecialityServices" ADD CONSTRAINT "UserSpecialityServices_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "Services"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSpecialityServices" ADD CONSTRAINT "UserSpecialityServices_speciality_id_fkey" FOREIGN KEY ("speciality_id") REFERENCES "Specialities"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSpecialityServices" ADD CONSTRAINT "UserSpecialityServices_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserVendors" ADD CONSTRAINT "UserVendors_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserVendors" ADD CONSTRAINT "UserVendors_vendor_id_fkey" FOREIGN KEY ("vendor_id") REFERENCES "Vendors"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VendorCarrier" ADD CONSTRAINT "VendorCarrier_carrier_id_fkey" FOREIGN KEY ("carrier_id") REFERENCES "Carriers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VendorCarrier" ADD CONSTRAINT "VendorCarrier_vendor_id_fkey" FOREIGN KEY ("vendor_id") REFERENCES "Vendors"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VendorServiceAreas" ADD CONSTRAINT "VendorServiceAreas_vendor_id_fkey" FOREIGN KEY ("vendor_id") REFERENCES "Vendors"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VendorSpecialty" ADD CONSTRAINT "VendorSpecialty_speciality_id_fkey" FOREIGN KEY ("speciality_id") REFERENCES "Specialities"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VendorSpecialty" ADD CONSTRAINT "VendorSpecialty_vendor_id_fkey" FOREIGN KEY ("vendor_id") REFERENCES "Vendors"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VendorUserPreferences" ADD CONSTRAINT "VendorUserPreferences_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VendorUserPreferences" ADD CONSTRAINT "VendorUserPreferences_vendor_id_fkey" FOREIGN KEY ("vendor_id") REFERENCES "Vendors"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vendors" ADD CONSTRAINT "Vendors_contact_id_fkey" FOREIGN KEY ("contact_id") REFERENCES "Contacts"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VideoRooms" ADD CONSTRAINT "VideoRooms_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "Conversations"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VideoRooms" ADD CONSTRAINT "VideoRooms_owner_contact_id_fkey" FOREIGN KEY ("owner_contact_id") REFERENCES "Contacts"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VoiceCalls" ADD CONSTRAINT "VoiceCalls_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "Conversations"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vouchers" ADD CONSTRAINT "Vouchers_claim_id_fkey" FOREIGN KEY ("claim_id") REFERENCES "Claims"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vouchers" ADD CONSTRAINT "Vouchers_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "VoucherTypes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkflowPublications" ADD CONSTRAINT "WorkflowPublications_task_work_id_fkey" FOREIGN KEY ("task_work_id") REFERENCES "Works"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Works" ADD CONSTRAINT "Works_assignment_id_fkey" FOREIGN KEY ("assignment_id") REFERENCES "Assignments"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Works" ADD CONSTRAINT "Works_assignment_user_id_fkey" FOREIGN KEY ("assignment_user_id") REFERENCES "Users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Works" ADD CONSTRAINT "Works_assignment_workflow_pub_id_fkey" FOREIGN KEY ("assignment_workflow_pub_id") REFERENCES "WorkflowPublications"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Works" ADD CONSTRAINT "Works_claim_id_fkey" FOREIGN KEY ("claim_id") REFERENCES "Claims"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Works" ADD CONSTRAINT "Works_status_id_fkey" FOREIGN KEY ("status_id") REFERENCES "TaskStatuses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Works" ADD CONSTRAINT "Works_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "Tasks"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Works" ADD CONSTRAINT "Works_team_member_id_fkey" FOREIGN KEY ("team_member_id") REFERENCES "AssignmentTeamMembers"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "coffee_flavors_flavor" ADD CONSTRAINT "FK_25642975c6f620d570c635f418d" FOREIGN KEY ("flavorId") REFERENCES "flavor"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "coffee_flavors_flavor" ADD CONSTRAINT "FK_9cb98a3799afc95cf71fdb1c4f9" FOREIGN KEY ("coffeeId") REFERENCES "coffee"("id") ON DELETE CASCADE ON UPDATE CASCADE;
